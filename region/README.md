# region

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_regional"></a> [cluster\_regional](#input\_cluster\_regional) | Whether is a regional cluster (zonal cluster if set false. | `bool` | n/a | yes |
| <a name="input_cluster_zone_selector"></a> [cluster\_zone\_selector](#input\_cluster\_zone\_selector) | Selector for the cluster zone, either a number or '*' for all zones in the region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the cluster, will be used to generate the cluster name and database name. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the cluster in | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in, e.g. europe-west4 | `string` | n/a | yes |
| <a name="input_subnet_name_suffix"></a> [subnet\_name\_suffix](#input\_subnet\_name\_suffix) | Suffix for the subnet name, will be appended to the region name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_location"></a> [cluster\_location](#output\_cluster\_location) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_cluster_zones"></a> [cluster\_zones](#output\_cluster\_zones) | n/a |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | n/a |
| <a name="output_region_short"></a> [region\_short](#output\_region\_short) | n/a |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | n/a |
<!-- END_TF_DOCS -->
