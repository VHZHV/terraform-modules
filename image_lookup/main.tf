locals {
  image_tokens           = split("/", var.image)
  docker_registry_tokens = split("-", local.image_tokens[0])
}

data "google_artifact_registry_docker_image" "lookup" {
  project       = local.image_tokens[1]
  location      = join("-", slice(local.docker_registry_tokens, 0, length(local.docker_registry_tokens) - 1))
  repository_id = local.image_tokens[2]
  image_name    = join("/", slice(local.image_tokens, 3, length(local.image_tokens)))
}
