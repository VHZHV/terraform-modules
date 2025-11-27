resource "helm_release" "otel_collector_sidecar" {
  name             = "otel-collector-sidecar"
  repository       = "oci://europe-docker.pkg.dev"
  chart            = "hozah-artifacts/docker/hozah/otel-collector-sidecar"
  version          = "1.7.0"
  namespace        = var.k8s_namespace
  create_namespace = true
}
