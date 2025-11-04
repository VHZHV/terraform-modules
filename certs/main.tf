resource "google_certificate_manager_certificate" "certs" {
  count = length(var.domains)

  name = "${var.prefix}-cert-${count.index}"
  managed {
    domains = [var.domains[count.index]]
  }
}

resource "google_certificate_manager_certificate_map_entry" "service_cert_map_entries" {
  count = length(var.domains)

  hostname     = var.domains[count.index]
  name         = "${google_certificate_manager_certificate.certs[count.index].name}-entry"
  map          = var.map
  certificates = [google_certificate_manager_certificate.certs[count.index].id]
}
