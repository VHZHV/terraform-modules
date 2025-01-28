terraform {
  required_version = ">=1.7.2"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

resource "google_sql_user" "app_user" {
  name     = trimsuffix(var.service_account_email, ".gserviceaccount.com")
  instance = reverse(split(":", var.instance_connection_name))[0]
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}

locals {
  code_hash = sha1(join("", [
    for f in fileset("${path.module}/scripts/grant_sql_access", "*") : filesha1("${path.module}/scripts/grant_sql_access/${f}")
  ], var.extra_commands))
}

resource "null_resource" "run_grant_sql_access" {
  triggers = {
    always_run = "${local.code_hash}-${google_sql_user.app_user.name}"
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/scripts/grant_sql_access"
    command     = "npm run exec"
    environment = {
      INSTANCE_CONNECTION_NAME = var.instance_connection_name
      USER_NAME                = var.user_name
      USER_PASSWORD            = var.user_password
      DATABASE_NAME            = var.database_name
      APP_USERNAME             = google_sql_user.app_user.name
      EXTRA_COMMANDS           = join("", var.extra_commands)
    }
  }
}
