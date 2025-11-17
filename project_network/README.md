# project_network

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | < 8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | < 8 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns_zone"></a> [dns\_zone](#module\_dns\_zone) | terraform-google-modules/cloud-dns/google | 6.1.0 |
| <a name="module_private-service-access"></a> [private-service-access](#module\_private-service-access) | terraform-google-modules/sql-db/google//modules/private_service_access | 26.2.2 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | 13.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_dns_record_set.domain](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_record_managed_zone"></a> [dns\_record\_managed\_zone](#input\_dns\_record\_managed\_zone) | Managed zone where the DNS record will be created. Typically 'hozahproduction'. | `string` | n/a | yes |
| <a name="input_dns_record_project"></a> [dns\_record\_project](#input\_dns\_record\_project) | Project where the DNS record will be created. Typically parking. | `string` | n/a | yes |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | Name of the DNS zone to be created. | `string` | n/a | yes |
| <a name="input_ip_range_pods_name"></a> [ip\_range\_pods\_name](#input\_ip\_range\_pods\_name) | Name of the IP range for pods. This will end up being used for the GKE cluster pods. | `string` | n/a | yes |
| <a name="input_ip_range_services_name"></a> [ip\_range\_services\_name](#input\_ip\_range\_services\_name) | Name of the IP range for services. This will end up being used for the GKE cluster services. | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the network to be created. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project id tier will be setup. | `string` | n/a | yes |
| <a name="input_regions"></a> [regions](#input\_regions) | Regions that should have a network available, can be used to disaster recovery. | `list(string)` | n/a | yes |
| <a name="input_subnet_name_suffix"></a> [subnet\_name\_suffix](#input\_subnet\_name\_suffix) | Suffix for the subnet names. This will be appended to the region name to create unique subnet names. | `string` | n/a | yes |
| <a name="input_top_level_domain_name"></a> [top\_level\_domain\_name](#input\_top\_level\_domain\_name) | Top level domain name for the DNS zone. Something like 'console.hozah.com'. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
