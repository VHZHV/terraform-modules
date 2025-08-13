locals {
  otel_sidecar_config_name = "otel-sidecar-config"
}

resource "helm_release" "otel_sidecar_config" {
  name  = "otel-collector-sidecar"
  chart = "${path.module}/chart"

  namespace        = var.k8s_namespace
  create_namespace = true

  values = [
    yamlencode(merge(
      {
        telemetry = {
          enabled = var.telemetry_enabled
        },
        otel_sidecar_config = {
          name = local.otel_sidecar_config_name
        }
      },
    )),
  ]
}
