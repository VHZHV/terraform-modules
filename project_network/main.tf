module "dns_zone" {
  source  = "terraform-google-modules/cloud-dns/google"
  version = "7.1.0"

  project_id = var.project_id
  type       = "public"
  name       = var.dns_zone_name
  domain     = "${var.top_level_domain_name}."

  dnssec_config = {
    state = "on"
  }
}

resource "google_dns_record_set" "domain" {
  project = var.dns_record_project

  managed_zone = var.dns_record_managed_zone

  name    = "${var.top_level_domain_name}."
  type    = "NS"
  ttl     = 300
  rrdatas = module.dns_zone.name_servers
}


module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "13.1.0"

  project_id                   = var.project_id
  network_name                 = var.network_name
  routing_mode                 = "GLOBAL"
  bgp_best_path_selection_mode = "STANDARD"

  subnets = [
    for idx, region in var.regions : {
      subnet_name           = "${region}-${var.subnet_name_suffix}"
      subnet_ip             = "10.10.${10 + idx}.0/24"
      subnet_region         = region
      subnet_private_access = true
      description           = "This subnet is managed by Terraform"
    }
  ]
  secondary_ranges = {
    for idx, region in var.regions : "${region}-${var.subnet_name_suffix}" => [
      {
        range_name    = var.ip_range_pods_name
        ip_cidr_range = "192.168.${idx * 64}.0/19"
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = "192.168.${(idx * 64) + 32}.0/24"
      },
    ]
  }
}

module "private-service-access" {
  depends_on = [module.vpc]

  source  = "terraform-google-modules/sql-db/google//modules/private_service_access"
  version = "27.2.0"

  project_id      = var.project_id
  vpc_network     = module.vpc.network_name
  deletion_policy = "ABANDON"
}
