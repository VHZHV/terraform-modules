variable "instance_connection_name" {
  description = "Cloud SQL connection name"
  type        = string
}

variable "user_name" {
  description = "Admin username"
  type        = string
}

variable "user_password" {
  description = "Admin password"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "Name of the database inside the instance connection"
  type        = string
}

variable "extra_commands" {
  description = "Extra commands to run after the database is created"
  type        = list(string)
  default     = []
}
