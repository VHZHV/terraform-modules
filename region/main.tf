data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
}

module "region_short" {
  source = "../region_short"

  region = var.region
}

locals {
  replica_region = length(var.regions) > 1 ? ((var.region) == var.regions[0] ? var.regions[1] : var.regions[0]) : ""
}

module "replica_region_short" {
  count = local.replica_region == "" ? 0 : 1

  source = "../region_short"

  region = local.replica_region
}

data "google_compute_zones" "replica_available" {
  count = local.replica_region == "" ? 0 : 1

  project = var.project_id
  region  = local.replica_region
}
