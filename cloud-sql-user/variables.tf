variable "instance_connection_name" {
  description = "Cloud SQL connection name"
  type        = string
}

variable "service_account_email" {
  description = "User name for the application, which permissions will be granted"
  type        = string
}
