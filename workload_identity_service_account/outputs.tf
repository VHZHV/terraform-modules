output "service_account" {
  value       = google_service_account.sa
  description = "The service account created for the workload identity pool"
}
