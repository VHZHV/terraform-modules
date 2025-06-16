output "token" {
  value = data.google_client_config.default.access_token
}
output "host" {
  value = "https://${data.google_container_cluster.cluster.endpoint}"
}
output "cluster_ca_certificate" {
  value = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
}
