# Design library API key

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_sendgrid"></a> [sendgrid](#requirement\_sendgrid) | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_sendgrid"></a> [sendgrid](#provider\_sendgrid) | ~> 1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [sendgrid_api_key.design_library_api_key](https://registry.terraform.io/providers/anna-money/sendgrid/latest/docs/resources/api_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the sendgrid API key | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_key"></a> [api\_key](#output\_api\_key) | n/a |
<!-- END_TF_DOCS -->
