# service account and perms and such for pohara's drone runners
resource "google_service_account" "pohara-drone" {
  account_id = "pohara-drone"
}
