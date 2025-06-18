# cluster

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google | 37.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_autoscaling_enabled"></a> [cluster\_autoscaling\_enabled](#input\_cluster\_autoscaling\_enabled) | Whether cluster autoscaling is enabled. | `bool` | `true` | no |
| <a name="input_cluster_autoscaling_profile"></a> [cluster\_autoscaling\_profile](#input\_cluster\_autoscaling\_profile) | Defines possible options for autoscalingProfile field. | `string` | n/a | yes |
| <a name="input_cluster_max_cpu_cores"></a> [cluster\_max\_cpu\_cores](#input\_cluster\_max\_cpu\_cores) | Number of CPU cores to use for the cluster autoscaling. | `number` | n/a | yes |
| <a name="input_cluster_max_memory_gb"></a> [cluster\_max\_memory\_gb](#input\_cluster\_max\_memory\_gb) | Number of GB of memory to use for the cluster autoscaling. | `number` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster to create | `string` | n/a | yes |
| <a name="input_cluster_regional"></a> [cluster\_regional](#input\_cluster\_regional) | Whether is a regional cluster (zonal cluster if set to false). | `bool` | n/a | yes |
| <a name="input_cluster_zones"></a> [cluster\_zones](#input\_cluster\_zones) | The zones to create the cluster in, if regional is false | `list(string)` | n/a | yes |
| <a name="input_ip_range_pods_name"></a> [ip\_range\_pods\_name](#input\_ip\_range\_pods\_name) | The name of the IP range for pods in the cluster | `string` | n/a | yes |
| <a name="input_ip_range_services_name"></a> [ip\_range\_services\_name](#input\_ip\_range\_services\_name) | The name of the IP range for services in the cluster | `string` | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | The label to use for the cluster | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the network to create the cluster in | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the cluster in | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the subnet to create the cluster in | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
