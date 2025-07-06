variable "helm_timeout" {
  type        = number
  default     = 600
  description = "Helm timeout in seconds."
}
variable "k8s_namespace" {
  type        = string
  description = "Kubernetes namespace."
}

variable "version_tag" {
  type        = string
  description = "Version tag for the image."
}

variable "values" {
  type = list(string)
}
variable "chart" {
  type = string
}
variable "docker_registry" {
  type = string
}
variable "chart_location" {
  type = string
}