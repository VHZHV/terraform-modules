resource "random_shuffle" "password_length" {
  input        = range(30, 33) # Matches with ../sql-postgres/main.tf#password_validation_policy_config.min_length
  result_count = 1
}

resource "random_password" "admin_user_password" {
  length           = random_shuffle.password_length.result[0]
  special          = true
  override_special = "!$%*()-_=+[]{}:?"
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
}

resource "google_sql_user" "admin_user" {
  name        = "${var.database_name}-admin-user"
  instance    = var.cloud_sql_instance_name
  password_wo = random_password.admin_user_password.result
}

resource "google_sql_database" "main_database" {
  project  = var.project_id
  name     = var.database_name
  instance = var.cloud_sql_instance_name

  deletion_policy = var.deletable == "" ? "ABANDON" : "DELETE"
}
