provider "helm" {
  debug = true
  kubernetes {
    token                  = data.google_client_config.default.access_token
    host                   = "https://${data.google_container_cluster.cluster.endpoint}"
    cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
  }
}
