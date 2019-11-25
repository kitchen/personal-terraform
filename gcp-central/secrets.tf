resource "google_kms_key_ring" "kitchen-secrets" {
  name     = "kitchen-secrets"
  location = "us-central1"
}

resource "google_kms_crypto_key" "secrets-key" {
  name     = "secrets-key"
  key_ring = google_kms_key_ring.kitchen-secrets.self_link
}
