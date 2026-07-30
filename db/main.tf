resource "google_sql_user" "admin_user" {
  name        = var.user_name == "" ? "${var.database_name}-admin-user" : var.user_name
  instance    = var.cloud_sql_instance_name
  password_wo = var.password

  # Derived from the password rather than hardcoded, so it changes exactly when the password does.
  #
  # password_wo is write-only: it is never stored in state, so Terraform cannot compare it and cannot
  # see that it has changed. The provider's only trigger is password_wo_version --
  # `hasPasswordChange := d.HasChange("password") || d.HasChange("password_policy") ||
  # d.HasChange("password_wo_version")` -- and with a literal 1 that never fires. The result was that
  # var.password could change and the Cloud SQL user would silently keep its old password forever,
  # with no drift for Terraform to report.
  #
  # HasChange means *any* difference triggers the update, not a numeric increase, so a hash works;
  # password_wo_version is not ForceNew, so this updates in place rather than replacing the user.
  # Truncated to 7 hex digits to stay inside int32.
  password_wo_version = parseint(substr(sha256(var.password), 0, 7), 16)
}

resource "google_sql_database" "main_database" {
  project  = var.project_id
  name     = var.database_name
  instance = var.cloud_sql_instance_name

  deletion_policy = var.deletable == "" ? "ABANDON" : "DELETE"
}
