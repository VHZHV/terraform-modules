resource "random_shuffle" "password_length" {
  input        = range(30, 33) # Matches with ../sql-postgres/main.tf#password_validation_policy_config.min_length
  result_count = 1
}

resource "random_password" "admin_user_password" {
  length           = random_shuffle.password_length.result[0]
  special          = true
  override_special = "!$%*()-_=+[]{}:?"
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
}
