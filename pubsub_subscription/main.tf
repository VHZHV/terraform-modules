locals {
  pubsubHidden = "service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
  serviceAccounts = concat(var.service_account_email_addresses, [local.pubsubHidden])
}

data google_project "project"{
  project_id = var.project_id
}

resource "google_pubsub_topic" "deadletter_topic" {
  project = data.google_project.project.project_id
  name = "${var.environment}_${var.subscription_short_name}_deadletters"
}

resource "google_pubsub_subscription" "subscription" {
  project = data.google_project.project.project_id
  name  = "${var.environment}_${var.subscription_short_name}"
  topic = var.topic_id

  ack_deadline_seconds = 60

  retry_policy {
    minimum_backoff = "10s"
  }
  dead_letter_policy {
    max_delivery_attempts = 10
    dead_letter_topic     = google_pubsub_topic.deadletter_topic.id
  }
}

resource "google_pubsub_topic_iam_binding" "topic_access" {
  topic = google_pubsub_topic.deadletter_topic.id
  role  = "roles/pubsub.publisher"

  members = [
    # this is the hidden pubsub service account, needs permission
    "serviceAccount:${local.pubsubHidden}"
  ]
}

resource "google_pubsub_subscription_iam_binding" "subscription_access" {
  subscription = google_pubsub_subscription.subscription.id
  role         = "roles/pubsub.subscriber"

  members = [for serviceAccount in local.serviceAccounts : "serviceAccount:${serviceAccount}"]
}

