resource "helm_release" "custom_metrics_stackdriver_adapter" {
  name       = "custom-metrics-stackdriver-adapter"
  repository = "oci://europe-docker.pkg.dev"
  chart      = "hozah-artifacts/docker/hozah/custom-metrics-stackdriver-adapter"
  version    = "0.14.4"

  set = [
    {
      name  = "gcpServiceAccountEmail"
      value = google_service_account.custom_metrics.email
    },
  ]
}

resource "google_service_account" "custom_metrics" {
  project    = var.project_id
  account_id = "custom-metrics"
}

module "custom_metrics_project-iam-bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "8.2.0"

  projects = [var.project_id]
  mode     = "additive"

  bindings = {
    "roles/monitoring.viewer" = [
      "serviceAccount:${google_service_account.custom_metrics.email}",
    ]
  }
}

module "custom_metrics_service_account-iam-bindings" {
  source  = "terraform-google-modules/iam/google//modules/service_accounts_iam"
  version = "8.2.0"

  service_accounts = [google_service_account.custom_metrics.email]
  project          = var.project_id
  mode             = "additive"
  bindings = {
    "roles/iam.workloadIdentityUser" = [
      "serviceAccount:${var.project_id}.svc.id.goog[custom-metrics/custom-metrics-stackdriver-adapter]"
    ]
  }
}
