resource "helm_release" "otel-sidecar-config" {
  name             = "otel-sidecar-config"
  repository       = "oci://europe-docker.pkg.dev"
  chart            = "hozah-artifacts/docker/hozah/otel-sidecar-config"
  version          = "1.0.0"
  namespace        = var.k8s_namespace
  create_namespace = true
}
