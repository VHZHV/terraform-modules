variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in"
}
variable "region" {
  type = string
}
variable "dns_domain" {
  type = string
}
variable "dns_managed_zone" {
  type = string
}
variable "domains" {
  type = list(string)
}

variable "name_prefix" {
  type = string
}
variable "name_suffix" {
  type = string
}
