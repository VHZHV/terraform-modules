output "name" {
  value = kubernetes_config_map_v1.otel_sidecar_config.metadata[0].name
}
