output "kubernetes" {
  value = {
    token                  = data.google_client_config.default.access_token
    host                   = "https://${data.google_container_cluster.cluster.endpoint}"
    cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
  }
}

output "hozah_registry" {
  value = {
    url      = "oci://europe-docker.pkg.dev"
    username = "oauth2accesstoken"
    password = data.google_client_config.default.access_token
  }
}
