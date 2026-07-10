variable "project_id" {
  type        = string
  description = "Project id where environment will be deployed."
}

variable "k8s_namespace" {
  type        = string
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
