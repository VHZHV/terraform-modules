# Image Lookup

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 7.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | ~> 7.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_artifact_registry_docker_image.lookup](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/artifact_registry_docker_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_image"></a> [image](#input\_image) | n/a | `string` | n/a | yes |
| <a name="input_lookup"></a> [lookup](#input\_lookup) | n/a | `bool` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_link"></a> [link](#output\_link) | n/a |
<!-- END_TF_DOCS -->
