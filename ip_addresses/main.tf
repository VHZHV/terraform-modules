locals {
  any_root            = anytrue([for domain in var.domains : (domain == var.dns_domain)])
  higher_level_domain = join(".", slice(split(".", var.dns_domain), 1, length(split(".", var.dns_domain))))

  used_dns_domain = local.any_root ? local.higher_level_domain : var.dns_domain

  dns_names = [for dns_name in var.domains : replace(dns_name, ".${local.used_dns_domain}", "")]
}

module "ip_addresses" {
  source  = "terraform-google-modules/address/google"
  version = "5.0.0"

  names = [
    for dns_name in local.dns_names : "${var.name_prefix}-${replace(dns_name, ".", "-")}-ip-${var.name_suffix}"
  ]

  global     = true
  project_id = var.project_id
  region     = var.region

  enable_cloud_dns = true

  address_type     = "EXTERNAL"
  dns_domain       = local.used_dns_domain
  dns_managed_zone = var.dns_managed_zone

  dns_short_names = local.dns_names
  dns_record_type = "A"
  dns_ttl         = 300
}
