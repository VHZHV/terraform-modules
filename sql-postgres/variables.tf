variable "project_id" {
  type        = string
  description = "The project ID to host the db in"
}

variable "region" {
  type        = string
  description = "The region to host the db in"
}
variable "db_zone_selector" {
  type        = string
  description = "Zone selector for the database. If set to *, all zones will be used."
}
variable "network_name" {
  type        = string
  description = "The name of the network to use for the database"
}
variable "db_name" {
  type        = string
  description = "The name of the database to create"
}
variable "db_available_type" {
  type        = string
  description = "Defines possible options for autoscalingProfile field."
}
variable "db_backup" {
  type        = bool
  description = "Whether to enable database backup."
}

variable "db_insights" {
  type        = bool
  description = "Whether to enable database insights."
}
variable "deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection for the database."
}
variable "tier" {
  description = "The tier for the Cloud SQL instance."
  type        = string
  default     = "db-f1-micro"
}
locals {
  zones   = data.google_compute_zones.available.names
  db_zone = var.db_zone_selector == "*" ? null : local.zones[tonumber(var.db_zone_selector)]
}
