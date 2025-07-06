# Hozah Helm Release

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.chart](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | n/a | `string` | n/a | yes |
| <a name="input_chart_location"></a> [chart\_location](#input\_chart\_location) | n/a | `string` | n/a | yes |
| <a name="input_docker_registry"></a> [docker\_registry](#input\_docker\_registry) | n/a | `string` | n/a | yes |
| <a name="input_helm_timeout"></a> [helm\_timeout](#input\_helm\_timeout) | Helm timeout in seconds. | `number` | `600` | no |
| <a name="input_k8s_namespace"></a> [k8s\_namespace](#input\_k8s\_namespace) | Kubernetes namespace. | `string` | n/a | yes |
| <a name="input_values"></a> [values](#input\_values) | n/a | `list(string)` | n/a | yes |
| <a name="input_version_tag"></a> [version\_tag](#input\_version\_tag) | Version tag for the image. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
