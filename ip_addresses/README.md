# IP Addresses

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ip_addresses"></a> [ip\_addresses](#module\_ip\_addresses) | terraform-google-modules/address/google | 5.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_domain"></a> [dns\_domain](#input\_dns\_domain) | n/a | `string` | n/a | yes |
| <a name="input_dns_managed_zone"></a> [dns\_managed\_zone](#input\_dns\_managed\_zone) | n/a | `string` | n/a | yes |
| <a name="input_domains"></a> [domains](#input\_domains) | n/a | `list(string)` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | n/a | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the cluster in | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_names"></a> [ip\_names](#output\_ip\_names) | n/a |
<!-- END_TF_DOCS -->
