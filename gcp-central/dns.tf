resource "google_dns_managed_zone" "kitchen-horse" {
  name        = "kitchen-horse"
  dns_name    = "kitchen.horse."
  description = "domain for GCP things ... horse"
}

output "kitchen-horse-zone-name" {
  value = google_dns_managed_zone.kitchen-horse.name
}

output "kitchen-horse-zone-dnsname" {
  value = google_dns_managed_zone.kitchen-horse.dns_name
}

resource "google_dns_record_set" "kitchen-horse-keybase" {
  name         = "_keybase.${google_dns_managed_zone.kitchen-horse.dns_name}"
  type         = "TXT"
  ttl          = 300
  managed_zone = google_dns_managed_zone.kitchen-horse.name
  rrdatas      = ["keybase-site-verification=2F_g-YHEpFqVYJ7dZD8tzxj3iJ8fJBOcdHy4JYI0emE"]
}


resource "google_dns_record_set" "kitchen-horse-caa" {
  # TODO: statefile
  project      = "central-259919"
  name         = "kitchen.horse."
  type         = "CAA"
  ttl          = 300
  managed_zone = "kitchen-horse"
  rrdatas = [
    "0 issue \"letsencrypt.org\"",
    "0 issue \"pki.goog\""
  ]
}
