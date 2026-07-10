output "values" {
  value = { for s in var.service_names : s => {
    kebab : provider::string-functions::kebab_case(s),
    account_name : trimsuffix(substr("${trimsuffix(substr(provider::string-functions::kebab_case(s), 0, 20), "-")}-${var.environment_name}", 0, 30), "-")
  } }
}
