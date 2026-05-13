output "link" {
  value = var.lookup ? data.google_artifact_registry_docker_image.lookup.self_link : var.image
}
