variable "project_id" {
  type        = string
  description = "Project id where environment will be deployed."
}

variable "k8s_namespace" {
  type        = string
  description = "Kubernetes namespace."
}

variable "name" {
  type = string
}

variable "roles" {
  type        = list(string)
  description = "Extra roles"
}
