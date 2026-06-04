module "hozah_helm" {
  source = "../hozah_helm"
}

resource "helm_release" "otel_collector_sidecar" {
  name             = "otel-collector-sidecar"
  repository       = module.hozah_helm.repository
  chart            = "${module.hozah_helm.chart_root}/otel-collector-sidecar"
  version          = module.hozah_helm.version
  namespace        = var.k8s_namespace
  create_namespace = true
}
