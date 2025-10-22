variable "project_id" {
  type        = string
  description = "Project id where environment will be deployed."
}

variable "k8s_namespace" {
  type        = string
  description = "Kubernetes namespace."
}

variable "region_short" {
  type = string
  validation {
    condition     = length(var.region_short) == 3
    error_message = "region_short to be 3 chars long, e.g. ew2"
  }
  description = "Kubernetes namespace."
}

variable "service_name" {
  type        = string
  description = "Kubernetes namespace."
}

variable "environment_name" {
  type        = string
  description = "Environment name."
}

variable "roles" {
  type        = list(string)
  description = "Extra roles"
}
