output "name" {
  value = kubernetes_config_map.otel_sidecar_config.metadata[0].name
}
