data "google_client_config" "default" {}

data "google_container_cluster" "cluster" {
  project  = var.project_id
  location = var.cluster_location
  name     = var.cluster_name
}
