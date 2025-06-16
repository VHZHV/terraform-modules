variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in"
}
variable "region" {
  type = string
}
variable "cluster_regional" {
  type        = bool
  description = "Whether is a regional cluster (zonal cluster if set false."
}
variable "cluster_zone_selector" {
  description = "Selector for the cluster zone, either a number or '*' for all zones in the region."
  type        = string
}
variable "subnet_name_suffix" {
  description = "Suffix for the subnet name, will be appended to the region name."
  type        = string
}

locals {
  _region_short = join("", [for s in split("-", var.region) : substr(s, 0, 1)])
  region_short  = "${local._region_short}${substr(var.region, length(var.region) - 1, 1)}"

  zones = data.google_compute_zones.available.names
  cluster_zones = (var.cluster_zone_selector == "*" ? tolist(local.zones) :
  [local.zones[tonumber(var.cluster_zone_selector)]])
}
