output "subscription" {
  value = google_pubsub_subscription.subscription
}

output "deadletter_topic"{
  value = google_pubsub_topic.deadletter_topic
}