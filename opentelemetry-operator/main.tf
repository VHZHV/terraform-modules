resource "helm_release" "k8s_operator_for_opentelemetry" {
  name             = "opentelemetry-operator"
  repository       = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart            = "opentelemetry-operator"
  version          = "0.91.0"
  create_namespace = true
  set = [{
    name  = "manager.collectorImage.repository"
    value = "otel/opentelemetry-collector-contrib"
  }]
}
