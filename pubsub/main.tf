locals {
  # Convention: All of the projects resources must be self-managed
  create_topic = var.topic.project_id == null || var.topic.project_id == var.project_id
}

data "google_pubsub_topic" "root_topic" {
  count = local.create_topic ? 0 : 1

  project = var.topic.project_id
  name    = var.topic.name
}

# trivy:ignore:avd-gcp-0011 This is part of the module, and only adds it the pubsub project
module "pubsub" {
  source     = "terraform-google-modules/pubsub/google"
  version    = "8.8.1"
  depends_on = [module.dead_letter_pubsub]

  project_id          = var.project_id
  grant_token_creator = false

  create_topic = local.create_topic
  topic        = local.create_topic ? var.topic.name : data.google_pubsub_topic.root_topic[0].id

  topic_message_retention_duration = var.message_retention_duration

  pull_subscriptions = [
    {
      name                         = var.subscription_name
      ack_deadline_seconds         = var.ack_deadline_seconds
      expiration_policy            = var.expiration_policy
      dead_letter_topic            = module.dead_letter_pubsub[var.subscription_name].id
      max_delivery_attempts        = var.max_delivery_attempts
      retain_acked_messages        = var.retain_acked_messages
      message_retention_duration   = var.message_retention_duration
      maximum_backoff              = var.maximum_backoff
      minimum_backoff              = var.minimum_backoff
      enable_message_ordering      = var.enable_message_ordering
      enable_exactly_once_delivery = var.enable_exactly_once_delivery
      filter                       = var.filter
    },
  ]
}

module "dead_letter_pubsub" {
  source = "../dead_letter_topic"

  for_each = toset([
    var.subscription_name
  ])

  project_id = var.project_id

  root_topic_name = each.value

  message_retention_duration              = var.message_retention_duration
  subscription_expiration_policy          = var.expiration_policy
  subscription_message_retention_duration = var.message_retention_duration
}


data "google_project" "project" {
  project_id = var.project_id
}
module "dead_letter_pubsub_topic-iam-bindings" {
  depends_on = [module.dead_letter_pubsub]

  count = local.create_topic ? 0 : 1

  source  = "terraform-google-modules/iam/google//modules/pubsub_topics_iam"
  version = "8.3.0"

  project       = var.project_id
  pubsub_topics = [for topic in module.dead_letter_pubsub : topic.id]
  mode          = "additive"

  bindings = {
    "roles/pubsub.publisher" = [
      "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com",
    ]
  }
}
