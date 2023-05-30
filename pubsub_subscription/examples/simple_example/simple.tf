provider "google" {
}

resource google_service_account "test"{
  account_id = "test-sa"
}

resource google_pubsub_topic "topic" {
  name = "example-topic"
}

data google_project "project"{}

module "pubsub_subscription" {
  source = "github.com/VHZHV/terraform-modules//pubsub_subscription"
  environment = "test"
  service_account_email_addresses = [google_service_account.test.email]
  project = {
    id = data.google_project.project.id
  }
  subscription_short_name = "example_sub"
  topic_id = google_pubsub_topic.topic.id

}