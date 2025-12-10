resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.19.2"
  create_namespace = true
  set = [{
    name  = "crds.enabled"
    value = "true"
  }]
}
