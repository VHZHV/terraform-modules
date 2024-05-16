variable "cluster_name" {
  type        = string
  description = "Name of the cluster, will be included in resource names"
}

variable "environment" {
  type        = string
  description = "Name of the environment, will be included in resource names"
}

variable "project_id" {
  type        = string
  description = "GCP project id"
}

variable "service_account_short_name" {
  type        = string
  description = "Service account name to be used with workload identity in cluster"
}

variable "k8s_namespace" {
  type        = string
  default     = "default"
  description = "The namespace of the k8s service account"
}
