resource "google_dns_managed_zone" "kitchen-horse" {
  name        = "kitchen-horse"
  dns_name    = "kitchen.horse."
  description = "domain for GCP things ... horse"
}

output "kitchn-horse-zone-name" {
  value = google_dns_managed_zone.kitchen-horse.name
}
