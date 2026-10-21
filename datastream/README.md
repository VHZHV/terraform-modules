# Datastream

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 7.31 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | >= 7.31 |
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_datastream_connection_profile.bigquery_destination](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/datastream_connection_profile) | resource |
| [google_datastream_connection_profile.postgres_source](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/datastream_connection_profile) | resource |
| [google_datastream_stream.stream](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/datastream_stream) | resource |
| [google_sql_user.datastream_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [null_resource.run_datastream_setup](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_backfill"></a> [backfill](#input\_backfill) | Whether the stream backfills existing rows: all or none. | `string` | `"all"` | no |
| <a name="input_bigquery_region"></a> [bigquery\_region](#input\_bigquery\_region) | The BigQuery region. | `string` | n/a | yes |
| <a name="input_db"></a> [db](#input\_db) | n/a | <pre>object({<br/>    connection_name   = string<br/>    name              = string<br/>    public_ip_address = string<br/>    database_name     = string<br/>    user_name         = string<br/>    user_password     = string<br/>  })</pre> | n/a | yes |
| <a name="input_desired_state"></a> [desired\_state](#input\_desired\_state) | Desired stream state: NOT\_STARTED, RUNNING or PAUSED. | `string` | `"RUNNING"` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Environment name. | `string` | n/a | yes |
| <a name="input_group"></a> [group](#input\_group) | Something like console, account, enforcement | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Optional suffix for the datastream user, publication and replication slot names. Required when several instances of this module share one Cloud SQL instance. | `string` | `null` | no |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the cluster in | `string` | n/a | yes |
| <a name="input_publication_tables"></a> [publication\_tables](#input\_publication\_tables) | Bare table names in schema public to publish. When null the publication is FOR ALL TABLES and setup errors are logged and ignored; when set the publication lists only these tables and setup fails on any error. | `list(string)` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | n/a | yes |
| <a name="input_table_partitioning"></a> [table\_partitioning](#input\_table\_partitioning) | BigQuery time-unit partitioning per table, keyed by bare table name in schema public. | <pre>map(object({<br/>    column      = string<br/>    granularity = optional(string, "DAY")<br/>  }))</pre> | `{}` | no |
| <a name="input_tables"></a> [tables](#input\_tables) | n/a | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
