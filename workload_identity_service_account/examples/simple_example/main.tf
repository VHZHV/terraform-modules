terraform {
  required_version = ">=1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "< 8"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_project" "project" {
}

resource "google_container_cluster" "cluster" {
  name     = "cluster"
  location = var.region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  network_policy {
    enabled = true
  }
  private_cluster_config {
    enable_private_nodes = true
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.10.128.0/24"
      display_name = "internal"
    }
  }
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

module "workload_identity_sa" {
  #  source = "github.com/VHZHV/terraform-modules//workload_identity_service_account"
  source                     = "../.."
  environment                = "test"
  cluster_name               = google_container_cluster.cluster.name
  project_id                 = data.google_project.project.project_id
  service_account_short_name = "example"
}
