module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "11.1.1"

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
        ip_cidr_range = "192.168.${idx * 16}.0/21"
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = "192.168.${(idx * 16) + 8}.0/21"
      },
    ]
  }
}

module "private-service-access" {
  depends_on = [module.vpc]

  source  = "terraform-google-modules/sql-db/google//modules/private_service_access"
  version = "25.2.2"

  project_id      = var.project_id
  vpc_network     = module.vpc.network_name
  deletion_policy = "ABANDON"
}
