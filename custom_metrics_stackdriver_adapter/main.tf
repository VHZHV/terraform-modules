resource "helm_release" "custom_metrics_stackdriver_adapter" {
  name             = "custom-metrics-stackdriver-adapter"
  repository       = "oci://europe-docker.pkg.dev"
  chart            = "hozah-artifacts/docker/hozah/custom-metrics-stackdriver-adapter"
  version          = "1.2.0"
  create_namespace = true
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_project_iam_member" "stackdriver_monitoring_viewer" {
  depends_on = [helm_release.custom_metrics_stackdriver_adapter]

  project = var.project_id
  role    = "roles/monitoring.viewer"
  member  = "principal://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${data.google_project.project.project_id}.svc.id.goog/subject/ns/custom-metrics/sa/custom-metrics-stackdriver-adapter"
}
