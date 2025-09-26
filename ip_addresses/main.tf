locals {
  dns_names = [for dns_name in var.domains : replace(dns_name, ".${var.dns_domain}", "")]
}

module "ip_addresses" {
  source  = "terraform-google-modules/address/google"
  version = "4.2.0"

  names = [
    for dns_name in local.dns_names : "${var.name_prefix}-${replace(dns_name, ".", "-")}-ip-${var.name_suffix}"
  ]

  global     = true
  project_id = var.project_id
  region     = var.region

  enable_cloud_dns = true

  address_type     = "EXTERNAL"
  dns_domain       = var.dns_domain
  dns_managed_zone = var.dns_managed_zone

  dns_short_names = local.dns_names
  dns_record_type = "A"
  dns_ttl         = 300
}
