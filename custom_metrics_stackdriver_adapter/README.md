# Custom Metrics Stackdriver Adapter

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | < 8 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | < 8 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_custom_metrics_project-iam-bindings"></a> [custom\_metrics\_project-iam-bindings](#module\_custom\_metrics\_project-iam-bindings) | terraform-google-modules/iam/google//modules/projects_iam | 8.2.0 |
| <a name="module_custom_metrics_service_account-iam-bindings"></a> [custom\_metrics\_service\_account-iam-bindings](#module\_custom\_metrics\_service\_account-iam-bindings) | terraform-google-modules/iam/google//modules/service_accounts_iam | 8.2.0 |

## Resources

| Name | Type |
|------|------|
| [google_service_account.custom_metrics](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [helm_release.custom_metrics_stackdriver_adapter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID deploy the custom metrics stackdriver adapter in | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
