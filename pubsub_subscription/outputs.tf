output "subscription" {
  value       = google_pubsub_subscription.subscription
  description = "The subscription created for the topic"
}

output "deadletter_topic" {
  value       = google_pubsub_topic.deadletter_topic
  description = "The deadletter topic created for the subscription"
}
