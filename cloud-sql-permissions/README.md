# cloud-sql-permissions

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.7.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.run_grant_sql_access](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name of the database inside the instance connection | `string` | n/a | yes |
| <a name="input_extra_commands"></a> [extra\_commands](#input\_extra\_commands) | Extra commands to run after the database is created | `list(string)` | `[]` | no |
| <a name="input_grantee"></a> [grantee](#input\_grantee) | The user to grant permissions to | `string` | n/a | yes |
| <a name="input_instance_connection_name"></a> [instance\_connection\_name](#input\_instance\_connection\_name) | Cloud SQL connection name | `string` | n/a | yes |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | Admin username | `string` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | Admin password | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
