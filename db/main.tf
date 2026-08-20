resource "google_sql_user" "admin_user" {
  name                = var.user_name == "" ? "${var.database_name}-admin-user" : var.user_name
  instance            = var.cloud_sql_instance_name
  password_wo         = var.password
  password_wo_version = 1
}

resource "google_sql_database" "main_database" {
  project  = var.project_id
  name     = var.database_name
  instance = var.cloud_sql_instance_name

  # `deletable` is a bool, so comparing it to "" was never true and every
  # database got DELETE regardless of the flag — including production ones set
  # to false. Honour the variable as documented.
  deletion_policy = var.deletable ? "DELETE" : "ABANDON"
}
