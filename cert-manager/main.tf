resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.17.2"
  set {
    name  = "crds.enabled"
    value = "true"
  }
}
