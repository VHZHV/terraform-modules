variable "project_id" {
  type = string
}

variable "cloud_armor_id" {
  type = string
}

variable "ignored_rules" {
  type    = list(string)
  default = []
}
