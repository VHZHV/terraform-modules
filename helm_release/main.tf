locals {
  chart_name     = split("/kube-", var.chart)[1]
  chart_location = "kube/${local.chart_name}"
}

resource "helm_release" "chart" {
  repository = "oci://${var.docker_registry}"
  chart      = var.chart
  name       = "kube-${local.chart_name}"
  version    = var.version_tag
  namespace  = var.k8s_namespace

  timeout = var.helm_timeout

  create_namespace = true
  lint             = true

  set = [
    {
      name = "chartHash"
      value = sha1(join("", [
        for f in fileset("../../${local.chart_location}", "**/*.yaml") : filesha1("../../${local.chart_location}/${f}")
      ]))
    }
  ]

  values = var.values
}
