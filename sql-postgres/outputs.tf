output "instance_name" {
  description = "The name of the Cloud SQL instance."
  value       = module.sql-db_postgresql.instance_name
}

output "database_flags" {
  description = "The database flags configured on the Cloud SQL instance."
  value       = local.database_flags
}
