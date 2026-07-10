locals {
  _region_short = join("", [for s in split("-", var.region) : substr(s, 0, 1)])
}
