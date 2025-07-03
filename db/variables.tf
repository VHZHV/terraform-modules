variable "project_id" {
  type        = string
  description = "Project id where environment will be deployed."
}

variable "cloud_sql_instance_name" {
  type        = string
  description = "Name of the Cloud SQL instance."
}

variable "database_name" {
  type        = string
  description = "Name of the database to be created in the Cloud SQL instance."
}

variable "deletable" {
  type        = bool
  description = "Flag to indicate if the database can be deleted."
}
