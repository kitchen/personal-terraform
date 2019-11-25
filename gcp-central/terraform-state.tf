resource "google_storage_bucket" "kitchen-terraform" {
  name = "kitchen-terraform"
  versioning {
    enabled = true
  }
}
