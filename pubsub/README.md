# pubsub

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | > 6 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | > 6 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_dead_letter_pubsub"></a> [dead\_letter\_pubsub](#module\_dead\_letter\_pubsub) | ../dead_letter_topic | n/a |
| <a name="module_dead_letter_pubsub_topic-iam-bindings"></a> [dead\_letter\_pubsub\_topic-iam-bindings](#module\_dead\_letter\_pubsub\_topic-iam-bindings) | terraform-google-modules/iam/google//modules/pubsub_topics_iam | 8.3.0 |
| <a name="module_pubsub"></a> [pubsub](#module\_pubsub) | terraform-google-modules/pubsub/google | 8.8.1 |

## Resources

| Name | Type |
| ---- | ---- |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [google_pubsub_topic.root_topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/pubsub_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_ack_deadline_seconds"></a> [ack\_deadline\_seconds](#input\_ack\_deadline\_seconds) | n/a | `number` | `10` | no |
| <a name="input_enable_exactly_once_delivery"></a> [enable\_exactly\_once\_delivery](#input\_enable\_exactly\_once\_delivery) | n/a | `bool` | `true` | no |
| <a name="input_enable_message_ordering"></a> [enable\_message\_ordering](#input\_enable\_message\_ordering) | n/a | `bool` | `true` | no |
| <a name="input_expiration_policy"></a> [expiration\_policy](#input\_expiration\_policy) | n/a | `string` | `null` | no |
| <a name="input_filter"></a> [filter](#input\_filter) | n/a | `string` | `null` | no |
| <a name="input_max_delivery_attempts"></a> [max\_delivery\_attempts](#input\_max\_delivery\_attempts) | n/a | `number` | `100` | no |
| <a name="input_maximum_backoff"></a> [maximum\_backoff](#input\_maximum\_backoff) | n/a | `string` | `"600s"` | no |
| <a name="input_message_retention_duration"></a> [message\_retention\_duration](#input\_message\_retention\_duration) | n/a | `string` | `null` | no |
| <a name="input_minimum_backoff"></a> [minimum\_backoff](#input\_minimum\_backoff) | n/a | `string` | `"30s"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | n/a | yes |
| <a name="input_retain_acked_messages"></a> [retain\_acked\_messages](#input\_retain\_acked\_messages) | n/a | `bool` | `false` | no |
| <a name="input_subscription_name"></a> [subscription\_name](#input\_subscription\_name) | n/a | `string` | n/a | yes |
| <a name="input_topic"></a> [topic](#input\_topic) | n/a | <pre>object({<br/>    project_id = optional(string)<br/>    name       = string<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
