variable "k8s_namespace" {
  type        = string
  description = "Kubernetes namespace."
}

variable "telemetry_enabled" {
  type        = bool
  description = "Enable telemetry"
}
