resource "google_kms_key_ring" "vault" {
  name     = "vault"
  location = "us-central1"
}

resource "google_kms_crypto_key" "vault_seal" {
  name     = "vault_seal"
  key_ring = google_kms_key_ring.vault.self_link
}

resource "google_storage_bucket" "ssh-ca-vault" {
  name     = "ssh-ca-vault"
  location = "us-central1"
}
