module "hozah_helm" {
  source = "../hozah_helm"
}

resource "helm_release" "custom_metrics_stackdriver_adapter" {
  name       = "custom-metrics-stackdriver-adapter"
  repository = module.hozah_helm.repository
  chart      = "${module.hozah_helm.chart_root}/custom-metrics-stackdriver-adapter"
  version    = module.hozah_helm.version
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_project_iam_member" "stackdriver_monitoring_viewer" {
  project = var.project_id
  role    = "roles/monitoring.viewer"
  member  = "principal://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${data.google_project.project.project_id}.svc.id.goog/subject/ns/custom-metrics/sa/custom-metrics-stackdriver-adapter"
}
