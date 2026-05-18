variable "k8s_namespace" {
  type        = string
  description = "Kubernetes namespace."
}

variable "telemetry_enabled" {
  type        = bool
  description = "Enable telemetry"
}

variable "trace_sampling_ratio" {
  type        = number
  description = "parentbased_traceidratio sampler arg for OTEL_TRACES_SAMPLER_ARG. Suggested: 0.05 staging, 0.01 production."
  default     = 0.01
}
