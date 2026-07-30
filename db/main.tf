resource "google_sql_user" "admin_user" {
  name        = var.user_name == "" ? "${var.database_name}-admin-user" : var.user_name
  instance    = var.cloud_sql_instance_name
  password_wo = var.password

  password_wo_version = parseint(substr(sha256(var.password), 0, 7), 16)
}

resource "google_sql_database" "main_database" {
  project  = var.project_id
  name     = var.database_name
  instance = var.cloud_sql_instance_name

  deletion_policy = var.deletable == "" ? "ABANDON" : "DELETE"
}
