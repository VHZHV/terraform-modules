variable "project_id" {
  type        = string
  description = "Project id where environment will be deployed."
}
variable "root_topic_name" {
  type        = string
  description = "The Pub/Sub topic name."
}
variable "message_retention_duration" {
  type        = string
  description = "Message retention duration for the subscription."
}

variable "subscription_expiration_policy" {
  type        = string
  description = "Subscription expiration policy."
}

variable "subscription_message_retention_duration" {
  type        = string
  description = "Subscription message retention duration."
}