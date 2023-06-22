variable "service_account_email_addresses" {
  type = list(string)
  description = "service accounts that will use the subscription, the pubsub service account for this project will be auto-included"
}

variable "environment"{
  type = string
  description = "Name of the environment, will be included in resource names"
}

variable "project_id"{
  type = string
  description = "GCP project id"
}

variable "topic_id" {
  type = string
  description = "The full name of the topic e.g. project/foo/topic/bar"
}

variable "subscription_short_name"{
  type = string
  description = "Short name to use in the subscription to identify it. e.g thinghappened"
}

variable "enable_message_ordering" {
  type = bool
  default = false
}

variable "enable_exactly_once_delivery" {
  type = bool
  default = false
}