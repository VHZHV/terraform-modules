output "db_user_name" {
  description = "ID of the database user"
  value       = google_sql_user.app_user.name
}
