resource "helm_release" "k8s_operator_for_opentelemetry" {
  name             = "opentelemetry-operator"
  repository       = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart            = "opentelemetry-operator"
  version          = "0.115.0"
  create_namespace = true
  # Need the contrib distribution for googleclientauth / otlphttp.
  set = [{
    name  = "manager.collectorImage.repository"
    value = "otel/opentelemetry-collector-contrib"
  }]
}
