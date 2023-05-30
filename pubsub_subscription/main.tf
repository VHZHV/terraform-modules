

resource "google_pubsub_topic" "deadletter_topic" {
  name = "${var.environment}_${var.subscription_short_name}_deadletters"
}

resource "google_pubsub_subscription" "subscription" {
  name  = "${var.environment}_${var.subscription_short_name}"
  topic = var.topic_name

  ack_deadline_seconds = 60

  retry_policy {
    minimum_backoff = "10s"
  }
  dead_letter_policy {
    max_delivery_attempts = 10
    dead_letter_topic     = google_pubsub_topic.deadletter_topic.id
  }

}

resource "google_pubsub_topic_iam_binding" "binding" {
  topic = google_pubsub_topic.deadletter_topic.id
  role  = "roles/pubsub.publisher"

  members = [
    # this is the hidden pubsub service account, needs permission
    "serviceAccount:service-${var.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
  ]
}

locals {
  serviceAccounts = concat(var.service_account_email_addresses, ["service-${var.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"])
}

resource "google_pubsub_subscription_iam_binding" "pay_on_foot_ssv_validation_created_binding" {
  subscription = google_pubsub_subscription.subscription.id
  role         = "roles/pubsub.subscriber"

  members = [for serviceAccount in local.serviceAccounts : "serviceAccount:${serviceAccount}"]
}

