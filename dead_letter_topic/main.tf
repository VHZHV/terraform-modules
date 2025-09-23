locals {
  dead_letter_topic_suffix = "-dlq" # Configured to match with naming convention for alerting
  topic_name               = "${var.root_topic_name}${local.dead_letter_topic_suffix}"
}

# trivy:ignore:avd-gcp-0011 This is part of the module, and only adds it the pubsub project account
module "dead_letter_topic_pubsub" {
  source  = "terraform-google-modules/pubsub/google"
  version = "8.3.1"

  topic                            = local.topic_name
  project_id                       = var.project_id
  topic_message_retention_duration = var.message_retention_duration

  pull_subscriptions = [
    {
      name                         = "${var.root_topic_name}-dead-subscription"
      ack_deadline_seconds         = 10
      expiration_policy            = var.subscription_expiration_policy
      max_delivery_attempts        = 5
      retain_acked_messages        = false
      message_retention_duration   = var.subscription_message_retention_duration
      maximum_backoff              = "600s"
      minimum_backoff              = "30s"
      enable_message_ordering      = false
      enable_exactly_once_delivery = true
    },
  ]
}
