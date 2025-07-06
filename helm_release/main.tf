locals {
  chart_name = join("-", split("/", var.chart_location))
}

resource "helm_release" "chart" {
  name       = local.chart_name
  repository = "oci://${var.docker_registry}"
  chart      = var.chart
  version    = var.version_tag
  namespace  = var.k8s_namespace

  timeout = var.helm_timeout

  create_namespace = true
  lint             = true

  set = [
    {
      name = "chartHash"
      value = sha1(join("", [
        for f in fileset("../../${var.chart_location}", "**/*.yaml") : filesha1("../../${var.chart_location}/${f}")
      ]))
    }
  ]

  values = var.values
}
