resource "google_compute_instance_template" "vault" {
  name_prefix  = "vault-"
  machine_type = "f1-micro"
  region       = "us-central1"

  disk {
    source_image = "ubuntu-1804-lts"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    # TODO: statefile
    subnetwork         = "central-42"
    subnetwork_project = "central-259919"
  }

  lifecycle {
    create_before_destroy = true
  }

  metadata = {
    "user-data" = data.local_file.user-data.content
  }

  service_account {
    email  = google_service_account.vault-instance.email
    scopes = []
  }
}

data "local_file" "user-data" {
  filename = "user-data.yml"
}

resource "google_compute_instance_group_manager" "vault" {
  name               = "vault"
  base_instance_name = "vault"
  zone               = "us-central1-a"

  version {
    instance_template = google_compute_instance_template.vault.self_link
  }
}

resource "google_service_account" "vault-instance" {
  account_id   = "vault-instance"
  display_name = "Vault Instance"
  description  = "Service account for vault compute instances"
}
