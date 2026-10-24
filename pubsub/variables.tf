variable "project_id" {
  type = string
}

variable "topic" {
  type = object({
    project_id = optional(string)
    name       = string
  })
}

variable "subscription_name" {
  type = string
}

variable "ack_deadline_seconds" {
  type    = number
  default = 10
}
variable "expiration_policy" {
  type    = string
  default = null
}
variable "max_delivery_attempts" {
  type    = number
  default = 100
}
variable "retain_acked_messages" {
  type    = bool
  default = false
}
variable "message_retention_duration" {
  type    = string
  default = null
}
variable "maximum_backoff" {
  type    = string
  default = "600s"
}
variable "minimum_backoff" {
  type    = string
  default = "30s"
}
variable "filter" {
  type    = string
  default = null
}
variable "enable_message_ordering" {
  type    = bool
  default = true
}
variable "enable_exactly_once_delivery" {
  type    = bool
  default = true
}


