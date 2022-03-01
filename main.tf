resource "google_pubsub_topic" "topics" {
    for_each = {
        for n in var.topic_names: n => "${var.pubsub_prefix}${n}" 
    }
    name = each.value
}

resource "google_pubsub_subscription" "subscriptions" {
    for_each =  google_pubsub_topic.topics
    topic        = each.value.name
    name         = replace(each.value.name, "Topic", "Sub")
    depends_on   = [google_pubsub_topic.topics]
}

resource "google_logging_folder_sink" "log_sinks" {
    for_each        = google_pubsub_topic.topics
    name            = replace(each.value.name, "Topic", "Logging_Sink")
    description     = "Logging Sink for ${each.value.name}"
    folder          =  var.loggingsink_folder_id
    destination     = "pubsub.googleapis.com/${each.value.id}"
    #filter          = contains(keys(var.filters), "${each.value.name}") ? "yes" : "no filter"
    #filter          =  "${lookup(var.filters, "${each.value.name}")}"
    filter          = "${
                        lookup(var.filters, trimsuffix(trimprefix("${each.value.name}", var.pubsub_prefix), "_Topic"))
                        }"
}

resource "google_pubsub_topic_iam_member" "publisher" {
  for_each   = google_logging_folder_sink.log_sinks
  topic      = each.value.destination
  role       = "roles/pubsub.publisher"
  member     = "${each.value.writer_identity}"
  depends_on = [google_pubsub_topic.topics]
}

 resource "google_service_account" "sa" {
  account_id   = "soc-logging-service-account"
  display_name = "A service account for SOC logging purposes"
}

resource "google_project_iam_member" "admin-account-iam" {
    project = "global-soc-logging"
    role    = "roles/pubsub.subscriber" 
    member = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_service_account_key" "my_key" {
    service_account_id = google_service_account.sa.name
}

resource "google_secret_manager_secret" "my_secret" {
    secret_id = "soc-logging-secret"
    replication {
        automatic = true
     }
}

resource "google_secret_manager_secret_version" "my_secret_version_1" {
  secret      = google_secret_manager_secret.my_secret.id
  secret_data = google_service_account_key.my_key.private_key
  depends_on = [google_service_account_key.my_key]
}