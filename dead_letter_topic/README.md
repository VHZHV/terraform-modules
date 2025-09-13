# dead_letter_topic

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 7.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dead_letter_topic_pubsub"></a> [dead\_letter\_topic\_pubsub](#module\_dead\_letter\_topic\_pubsub) | terraform-google-modules/pubsub/google | 8.3.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_message_retention_duration"></a> [message\_retention\_duration](#input\_message\_retention\_duration) | Message retention duration for the subscription. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project id where environment will be deployed. | `string` | n/a | yes |
| <a name="input_root_topic_name"></a> [root\_topic\_name](#input\_root\_topic\_name) | The Pub/Sub topic name. | `string` | n/a | yes |
| <a name="input_subscription_expiration_policy"></a> [subscription\_expiration\_policy](#input\_subscription\_expiration\_policy) | Subscription expiration policy. | `string` | n/a | yes |
| <a name="input_subscription_message_retention_duration"></a> [subscription\_message\_retention\_duration](#input\_subscription\_message\_retention\_duration) | Subscription message retention duration. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END_TF_DOCS -->
