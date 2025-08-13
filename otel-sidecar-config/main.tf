resource "kubernetes_config_map" "otel_sidecar_config" {
  metadata {
    name      = "otel-sidecar-config"
    namespace = var.k8s_namespace

    labels = {
      maintained_by = "terraform"
    }
  }

  data = {
    OTEL_RESOURCE_PROVIDERS_GCP_ENABLED     = "true"
    OTEL_JAVAAGENT_ENABLED                  = var.telemetry_enabled
    OTEL_INSTRUMENTATION_MICROMETER_ENABLED = "true"
    OTEL_TRACES_EXPORTER                    = "otlp"
    OTEL_METRICS_EXPORTER                   = "otlp"
    OTEL_LOGS_EXPORTER                      = "otlp"
  }
}