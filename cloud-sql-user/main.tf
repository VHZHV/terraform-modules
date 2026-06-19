resource "google_sql_user" "app_user" {
  name     = trimsuffix(var.service_account_email, ".gserviceaccount.com")
  instance = reverse(split(":", var.instance_connection_name))[0]
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}
