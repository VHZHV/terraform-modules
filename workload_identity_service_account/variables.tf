variable "cluster_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "project_id" {
  type = string
}

variable "service_account_short_name" {
  type = string
}

variable "k8s_namespace" {
  type    = string
  default = "default"
}
