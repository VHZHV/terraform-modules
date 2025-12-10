# cloud-sql-user

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.7.2 |
| <a name="requirement_google"></a> [google](#requirement\_google) | < 8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | < 8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_user.app_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_connection_name"></a> [instance\_connection\_name](#input\_instance\_connection\_name) | Cloud SQL connection name | `string` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | User name for the application, which permissions will be granted | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_user_name"></a> [db\_user\_name](#output\_db\_user\_name) | ID of the database user |
<!-- END_TF_DOCS -->
