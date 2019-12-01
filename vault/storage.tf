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

# google_service_account.vault-instance
resource "google_storage_bucket_iam_member" "vault-instance-ssh-ca-vault" {
  bucket = google_storage_bucket.ssh-ca-vault.name
  role   = "roles/storage.objectAdmin"

  member = "serviceAccount:${google_service_account.vault-instance.email}"
}

resource "google_kms_crypto_key_iam_member" "vault-instances-vault-seal" {
  crypto_key_id = google_kms_crypto_key.vault_seal.self_link
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  member = "serviceAccount:${google_service_account.vault-instance.email}"
}
