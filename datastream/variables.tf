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

variable "password" {
  type      = string
  sensitive = true
}

variable "db" {
  type = object({
    connection_name   = string
    name              = string
    public_ip_address = string
    database_name     = string
    user_name         = string
    user_password     = string
  })
}

variable "name_suffix" {
  type        = string
  default     = null
  description = "Optional suffix for the datastream user, publication and replication slot names. Required when several instances of this module share one Cloud SQL instance."
}

variable "publication_tables" {
  type        = list(string)
  default     = null
  description = "Bare table names in schema public to publish. When null the publication is FOR ALL TABLES and setup errors are logged and ignored; when set the publication lists only these tables and setup fails on any error."

  validation {
    condition     = var.publication_tables == null || length(var.publication_tables) > 0
    error_message = "publication_tables must be null or a non-empty list; an empty list would otherwise publish all tables."
  }

  validation {
    condition     = alltrue([for t in coalesce(var.publication_tables, []) : can(regex("^[a-z_][a-z0-9_]*$", t))])
    error_message = "publication_tables entries must be bare table names (lowercase letters, digits, underscores), without a schema prefix."
  }
}

variable "backfill" {
  type        = string
  default     = "all"
  description = "Whether the stream backfills existing rows: all or none."

  validation {
    condition     = contains(["all", "none"], var.backfill)
    error_message = "backfill must be all or none."
  }
}

variable "desired_state" {
  type        = string
  default     = "RUNNING"
  description = "Desired stream state: NOT_STARTED, RUNNING or PAUSED."

  validation {
    condition     = contains(["NOT_STARTED", "RUNNING", "PAUSED"], var.desired_state)
    error_message = "desired_state must be NOT_STARTED, RUNNING or PAUSED."
  }
}

variable "table_partitioning" {
  type = map(object({
    column      = string
    granularity = optional(string, "DAY")
  }))
  default     = {}
  description = "BigQuery time-unit partitioning per table, keyed by bare table name in schema public."
}
