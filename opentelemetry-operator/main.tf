resource "helm_release" "k8s_operator_for_opentelemetry" {
  name             = "opentelemetry-operator"
  repository       = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart            = "opentelemetry-operator"
  version          = "0.109.0"
  create_namespace = true
  # Pin manager AND collector image tags. Chart 0.109.0 ships operator image
  # 0.120.0 by default; collector defaults can also drift. Leaving these
  # unpinned silently downgraded hozah-parking to a too-old collector.
  set = [{
    name  = "manager.collectorImage.repository"
    value = "otel/opentelemetry-collector-contrib"
    }, {
    name  = "manager.collectorImage.tag"
    value = "0.148.0"
    }, {
    name  = "manager.image.tag"
    value = "0.148.0"
  }]
}
