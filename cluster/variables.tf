variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in"
}

variable "region" {
  type        = string
  description = "The region to host the cluster in"
}

variable "cluster_regional" {
  type        = bool
  description = "Whether is a regional cluster (zonal cluster if set false."
}

variable "cluster_autoscaling_profile" {
  type        = string
  description = "Defines possible options for autoscalingProfile field."
}

variable "cluster_max_cpu_cores" {
  type        = number
  description = "Number of CPU cores to use for the cluster autoscaling."
}

variable "cluster_max_memory_gb" {
  type        = number
  description = "Number of GB of memory to use for the cluster autoscaling."
}

variable "cluster_autoscaling_enabled" {
  type        = bool
  description = "Whether cluster autoscaling is enabled."
  default     = true
}

variable "cluster_name" {
  type = string
}
variable "cluster_zones" {
  type = list(string)
}
variable "network_name" {
  type = string
}
variable "subnet_name" {
  type = string
}
variable "ip_range_pods_name" {
  type = string
}
variable "ip_range_services_name" {
  type = string
}

variable "label" {
  type = string
}
