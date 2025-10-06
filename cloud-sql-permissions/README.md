# cloud-sql-permissions

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.7.2 |
| <a name="requirement_google"></a> [google](#requirement\_google) | < 8 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | < 8 |
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_user.app_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [null_resource.run_grant_sql_access](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name of the database inside the instance connection | `string` | n/a | yes |
| <a name="input_extra_commands"></a> [extra\_commands](#input\_extra\_commands) | Extra commands to run after the database is created | `list(string)` | `[]` | no |
| <a name="input_instance_connection_name"></a> [instance\_connection\_name](#input\_instance\_connection\_name) | Cloud SQL connection name | `string` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | User name for the application, which permissions will be granted | `string` | n/a | yes |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | Admin username | `string` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | Admin password | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_user_name"></a> [db\_user\_name](#output\_db\_user\_name) | ID of the database user |
<!-- END_TF_DOCS -->
