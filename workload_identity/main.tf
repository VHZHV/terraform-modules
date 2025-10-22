module "workload_identity" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version = "41.0.0"

  name = "${var.region_short}-${substr(var.service_name, 0, 20)}-${var.environment_name}"

  project_id = var.project_id
  namespace  = var.k8s_namespace

  roles = [
    "roles/logging.logWriter",
    "roles/cloudtrace.agent",
    "roles/monitoring.metricWriter",
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
  ]
}
