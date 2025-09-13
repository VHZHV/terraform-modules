# Cloud SQL PostgreSQL Module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 7.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sql-db_postgresql"></a> [sql-db\_postgresql](#module\_sql-db\_postgresql) | terraform-google-modules/sql-db/google//modules/postgresql | 26.2.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_available_type"></a> [db\_available\_type](#input\_db\_available\_type) | Defines possible options for autoscalingProfile field. | `string` | n/a | yes |
| <a name="input_db_backup"></a> [db\_backup](#input\_db\_backup) | Whether to enable database backup. | `bool` | n/a | yes |
| <a name="input_db_insights"></a> [db\_insights](#input\_db\_insights) | Whether to enable database insights. | `bool` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database to create | `string` | n/a | yes |
| <a name="input_db_zone_selector"></a> [db\_zone\_selector](#input\_db\_zone\_selector) | Zone selector for the database. If set to *, all zones will be used. | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether to enable deletion protection for the database. | `bool` | n/a | yes |
| <a name="input_max_connections"></a> [max\_connections](#input\_max\_connections) | The maximum number of connections to the database. | `string` | `"2000"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the network to use for the database | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the db in | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the db in | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier for the Cloud SQL instance. | `string` | `"db-f1-micro"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
