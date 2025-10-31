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
  description = "Whether is a regional cluster (zonal cluster if set to false)."
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

variable "deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection for the database."
}

variable "cluster_name" {
  description = "The name of the cluster to create"
  type        = string
}
variable "cluster_zones" {
  description = "The zones to create the cluster in, if regional is false"
  type        = list(string)
}
variable "network_name" {
  description = "The name of the network to create the cluster in"
  type        = string
}
variable "subnet_name" {
  description = "The name of the subnet to create the cluster in"
  type        = string
}
variable "ip_range_pods_name" {
  description = "The name of the IP range for pods in the cluster"
  type        = string
}
variable "ip_range_services_name" {
  description = "The name of the IP range for services in the cluster"
  type        = string
}

variable "label" {
  description = "The label to use for the cluster"
  type        = string
}
