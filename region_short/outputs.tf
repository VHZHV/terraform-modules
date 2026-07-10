output "value" {
  value = "${local._region_short}${substr(var.region, length(var.region) - 1, 1)}"
}
