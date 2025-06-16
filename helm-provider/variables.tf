variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in"
}

variable "cluster_location" {
  type        = string
  description = "The region to host the cluster in"
}

variable "cluster_name" {
  type        = bool
  description = "Whether is a regional cluster (zonal cluster if set false."
}
