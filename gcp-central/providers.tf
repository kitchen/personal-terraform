provider "google" {
  project = "central-259919"
  region  = "us-central1"
}

resource "google_project_service" "dns" {
  service = "dns.googleapis.com"
}
