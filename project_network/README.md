# Pubsub subscrption
Creates a pull subscription to a pubsub topic, creates a deadletter topic for this subscripton, and allows a service
account to access it.

## Usage
See simple example

## Why not use the default resources?
* it's annoying to remember each time to do the IAM binding, typically you want a service account to access the queue
 
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
| <a name="module_private-service-access"></a> [private-service-access](#module\_private-service-access) | terraform-google-modules/sql-db/google//modules/private_service_access | 25.2.2 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | 11.1.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ip_range_pods_name"></a> [ip\_range\_pods\_name](#input\_ip\_range\_pods\_name) | Name of the IP range for pods. This will end up being used for the GKE cluster pods. | `string` | n/a | yes |
| <a name="input_ip_range_services_name"></a> [ip\_range\_services\_name](#input\_ip\_range\_services\_name) | Name of the IP range for services. This will end up being used for the GKE cluster services. | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the network to be created. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project id tier will be setup. | `string` | n/a | yes |
| <a name="input_regions"></a> [regions](#input\_regions) | Regions that should have a network available, can be used to disaster recovery. | `list(string)` | n/a | yes |
| <a name="input_subnet_name_suffix"></a> [subnet\_name\_suffix](#input\_subnet\_name\_suffix) | Suffix for the subnet names. This will be appended to the region name to create unique subnet names. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
