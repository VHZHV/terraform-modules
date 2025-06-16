output "cluster_name" {
  value = "anpr-${local.region_short}"
}

output "db_name" {
  value = "anpr-${local.region_short}"
}

output "region_short" {
  value = local.region_short
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
