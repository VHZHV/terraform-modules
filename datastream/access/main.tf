data "google_project" "dataform_projects" {
  for_each   = toset(var.bigquery_view_projects)
  project_id = each.value
}

resource "google_project_iam_member" "datastream_bigquery" {
  for_each = data.google_project.dataform_projects
  project  = var.project_id
  role     = "roles/bigquery.dataViewer"
  member   = "serviceAccount:service-${each.value.number}@gcp-sa-dataform.iam.gserviceaccount.com"
}
