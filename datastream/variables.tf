variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in"
}

variable "region" {
  type        = string
  description = "The region to host the cluster in"
}

variable "group" {
  type        = string
  description = "Something like console, account, enforcement"
}

variable "environment_name" {
  type        = string
  description = "Environment name."
}

variable "bigquery_region" {
  type        = string
  description = "The BigQuery region."
}

variable "tables" {
  type = list(string)
}

variable "db" {
  type = object({
    connection_name   = string
    database_name     = string
    name              = string
    public_ip_address = string
    user_name         = string
    user_password     = string
  })
}

