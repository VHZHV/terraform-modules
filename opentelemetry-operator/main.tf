resource "helm_release" "k8s_operator_for_opentelemetry" {
  name             = "opentelemetry-operator"
  repository       = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart            = "opentelemetry-operator"
  version          = "0.109.0"
  create_namespace = true
  # Override collector image repository to the *contrib* distribution.
  # The chart defaults to `opentelemetry-collector-k8s` which lacks
  # `googleclientauth`, `googlecloud`, and `otlphttp` — the components the
  # GMP migration needs. Tag comes from the chart default (0.148.0 in chart
  # 0.109.0). The operator manager image is similarly pinned by the chart's
  # appVersion to 0.148.0; no explicit tag pin needed.
  set = [{
    name  = "manager.collectorImage.repository"
    value = "otel/opentelemetry-collector-contrib"
  }]
}
