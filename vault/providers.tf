terraform {
  backend "gcs" {
    bucket = "kitchen-terraform"
    prefix = "personal-terraform/vault"
  }
}

provider "google" {
  project = "ssh-ca-vault"
  region  = "us-central1"
}

provider "google-beta" {
  project = "ssh-ca-vault"
  region  = "us-central1"
}


resource "google_project_service" "cloudkms" {
  service = "cloudkms.googleapis.com"
}

resource "google_project_service" "containerregistry" {
  service = "containerregistry.googleapis.com"
}

resource "google_compute_project_metadata_item" "enable-oslogin" {
  key   = "enable-oslogin"
  value = "TRUE"
}

resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_compute_shared_vpc_service_project" "ssh-ca-vault" {
  host_project    = "central-259919"
  service_project = "ssh-ca-vault"
}
