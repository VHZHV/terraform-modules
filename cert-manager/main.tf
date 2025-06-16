resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.18.0"
  set {
    name  = "crds.enabled"
    value = "true"
  }
}
