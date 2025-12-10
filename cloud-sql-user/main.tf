terraform {
  required_version = ">=1.7.2"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "< 8"
    }
  }
}

resource "google_sql_user" "app_user" {
  name     = trimsuffix(var.service_account_email, ".gserviceaccount.com")
  instance = reverse(split(":", var.instance_connection_name))[0]
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}
