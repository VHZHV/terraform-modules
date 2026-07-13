output "user_name" {
  value = google_sql_user.admin_user.name
}

output "user_password" {
  value     = var.password
  sensitive = true
}

output "database_name" {
  value = google_sql_database.main_database.name
}
