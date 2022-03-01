output "topics" {
    description = "name of topics"
    value = google_pubsub_topic.topics
    # value       = toset([
    #     for n in google_pubsub_topic.topics : n.name
    # ])
}

output "subscriptions" {
    description = "name of subscriptions"
    value = google_pubsub_subscription.subscriptions
    # value       = toset([
    #     for n in google_pubsub_subscription.subscriptions : n.name
    # ])
}

output "loggsinks" {
    description = "name of logging sinks"
    value = google_logging_folder_sink.log_sinks
    # value       = toset([
    #     for n in google_logging_folder_sink.log_sinks : n.name
    # ])
}

output "sa" {
    description = "name of sa"
    value = google_service_account.sa
}

output "google_service_account_key" {
    description = "sa key"
    value = google_service_account_key.my_key.private_key
    sensitive = true
}

output "google_secret_manager_secret" {
    description = "sa secret"
    value = google_secret_manager_secret.my_secret.name
}

