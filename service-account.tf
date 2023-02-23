# resource "google_service_account" "gcp-my-service" {
#     account_id = "gcp-my-service"
#     project = "ahmed-mossad"
  
# }
# resource "google_project_iam_member" "service-iam" {
#     project = "ahmed-mossad"
#     role = "roles/storage.admin"
#     member = "serviceAccount:${google_service_account.gcp-my-service.email}"
# }
resource "google_service_account" "instance-sa" {
  account_id = "instance-sa"
  display_name = "instance-sa"
}
resource "google_project_iam_member" "instance" {
  project = "ahmed-mossad"
  role = "roles/container.admin"
  member = "serviceAccount:${google_service_account.instance-sa.email}"
}

resource "google_service_account" "gcp-my-service" {
  account_id   = "gcp-my-service"
  display_name = "GKE service account"
}
resource "google_project_iam_member" "service-iam" {
    project = "ahmed-mossad"
    role = "roles/container.admin"
    member = "serviceAccount:${google_service_account.gcp-my-service.email}"
}