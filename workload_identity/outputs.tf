output "gcp_service_account_email" {
  value = module.workload_identity.gcp_service_account_email
}

output "k8s_service_account_name" {
  value = module.workload_identity.k8s_service_account_name
}
