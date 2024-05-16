terraform {
  required_version = ">=1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
}
data "google_project" "project" {
  project_id = var.project_id
}

variable "project_id" {
  type = string
}

resource "google_service_account" "test" {
  account_id = "test-sa"
}

resource "google_pubsub_topic" "topic" {
  name = "example-topic"
}

module "pubsub_subscription" {
  #  source = "github.com/VHZHV/terraform-modules//pubsub_subscription"
  source                          = "../.."
  environment                     = "test"
  service_account_email_addresses = [google_service_account.test.email]
  project_id                      = data.google_project.project.project_id
  subscription_short_name         = "example_sub"
  topic_id                        = google_pubsub_topic.topic.id
}
