variable "project_id" {
  type        = string
  description = "Project id tier will be setup."
}

variable "bigquery_view_projects" {
  type        = list(string)
  description = "List of Google projects whose default dataform service accounts should be granted view access to the BigQuery datasets."
}
