output "cluster_name" {
  value = "${var.name}-${module.region_short.value}"
}

output "db_name" {
  value = "${var.name}-${module.region_short.value}"
}

output "db_replica" {
  value = length(data.google_compute_zones.replica_available) == 0 ? null : {
    name = "${var.name}-${module.replica_region_short[0].value}"
    zone = data.google_compute_zones.replica_available[0].names[0]
  }
}

output "region_short" {
  value = module.region_short.value
}

output "subnet_name" {
  value = "${var.region}-${var.subnet_name_suffix}"
}

output "cluster_location" {
  value = var.cluster_regional ? var.region : local.cluster_zones[0]
}

output "cluster_zones" {
  value = local.cluster_zones
}
