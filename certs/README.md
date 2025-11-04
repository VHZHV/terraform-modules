# certs

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

No modules.

## Resources

| Name | Type |
|------|------|
| [google_certificate_manager_certificate.service_certs](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_certificate) | resource |
| [google_certificate_manager_certificate_map_entry.service_cert_map_entries](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_certificate_map_entry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domains"></a> [domains](#input\_domains) | List of domain names to be used for the certificates. | `list(string)` | n/a | yes |
| <a name="input_map"></a> [map](#input\_map) | Name of the certificate map. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to be used for naming the certificates. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
