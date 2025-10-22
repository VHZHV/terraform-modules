# Pubsub subscription

Creates a pull subscription to a pubsub topic, creates a deadletter topic for this subscripton, and allows a service
account to access it.

## Usage

See simple example

## Why not use the default resources?

- it's annoying to remember each time to do the IAM binding, typically you want a service account to access the queue

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1 |
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
| [google_pubsub_subscription.subscription](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_subscription_iam_binding.subscription_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription_iam_binding) | resource |
| [google_pubsub_topic.deadletter_topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic_iam_binding.topic_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic_iam_binding) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_exactly_once_delivery"></a> [enable\_exactly\_once\_delivery](#input\_enable\_exactly\_once\_delivery) | https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription#enable_exactly_once_delivery | `bool` | `false` | no |
| <a name="input_enable_message_ordering"></a> [enable\_message\_ordering](#input\_enable\_message\_ordering) | https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription#enable_message_ordering | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment, will be included in resource names | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project id | `string` | n/a | yes |
| <a name="input_service_account_email_addresses"></a> [service\_account\_email\_addresses](#input\_service\_account\_email\_addresses) | service accounts that will use the subscription, the pubsub service account for this project will be auto-included | `list(string)` | n/a | yes |
| <a name="input_subscription_short_name"></a> [subscription\_short\_name](#input\_subscription\_short\_name) | Short name to use in the subscription to identify it. e.g thinghappened | `string` | n/a | yes |
| <a name="input_topic_id"></a> [topic\_id](#input\_topic\_id) | The full name of the topic e.g. project/foo/topic/bar | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_deadletter_topic"></a> [deadletter\_topic](#output\_deadletter\_topic) | The deadletter topic created for the subscription |
| <a name="output_subscription"></a> [subscription](#output\_subscription) | The subscription created for the topic |
<!-- END_TF_DOCS -->
