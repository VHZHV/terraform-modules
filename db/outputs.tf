output "user_name" {
  value = google_sql_user.admin_user.name
}

output "user_password" {
  value = random_password.admin_user_password.result
}

output "database_name" {
  value = google_sql_database.main_database.name
}

