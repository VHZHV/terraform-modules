data google_project project{
  project_id = var.project_id
}

resource "google_service_account" "sa" {
  project = data.google_project.project.project_id
  account_id   = "${var.environment}-${var.service_account_short_name}"
  display_name = "Service Account for ${var.service_account_short_name} to be used with workload identity in cluster ${var.cluster_name}"
}

# allow the k8s service account to impersonate PoF's service account
resource "google_service_account_iam_binding" "gsa_ksa_binding" {
  service_account_id = google_service_account.sa.id
  role = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${data.google_project.project.project_id}.svc.id.goog[${var.k8s_namespace}/${var.service_account_short_name}]"
  ]
}

resource "google_project_iam_member" "logging_role"{
  project = data.google_project.project.project_id
  member = "serviceAccount:${google_service_account.sa.email}"
  role = "roles/logging.logWriter"
}

resource "google_project_iam_member" "monitoring_role"{
  project = data.google_project.project.project_id
  member = "serviceAccount:${google_service_account.sa.email}"
  role = "roles/monitoring.metricWriter"
}

resource "google_project_iam_member" "otel_roles" {
  project = data.google_project.project.project_id
  role = "roles/cloudtrace.agent"
  member  = "serviceAccount:${google_service_account.sa.email}"
}
