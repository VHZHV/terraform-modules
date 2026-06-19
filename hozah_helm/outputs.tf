# This mainly exists to keep everyone up to date with kubernetes-commons, as dependabot can't really look at helm in terraform
output "version" {
  value = "1.38.0"
}
output "repository" {
  value = "oci://europe-docker.pkg.dev"
}
output "chart_root" {
  value = "hozah-artifacts/docker/hozah/"
}
