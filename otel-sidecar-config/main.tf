resource "kubernetes_config_map" "otel_sidecar_config" {
  metadata {
    name      = "otel-sidecar-config"
    namespace = var.k8s_namespace
  }

  data = {
    OTEL_RESOURCE_PROVIDERS_GCP_ENABLED     = "true"
    OTEL_JAVAAGENT_ENABLED                  = "{{ .Values.telemetry.enabled }}"
    OTEL_INSTRUMENTATION_MICROMETER_ENABLED = "true"
    # For some reason these are needed to be set, the defaults don't seem to be defaults, I am guessing because of the buildpack
    # https://opentelemetry.io/docs/specs/otel/configuration/sdk-environment-variables/#exporter-selection
    OTEL_TRACES_EXPORTER  = "otlp"
    OTEL_METRICS_EXPORTER = "otlp"
    OTEL_LOGS_EXPORTER    = "otlp"
  }
}
