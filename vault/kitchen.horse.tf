# resource "google_storage_bucket" "kitchen-horse-web-us-central1" {
#   name   = "kitchen-horse-web-us-central1"
#   website {
#     main_page_suffix = "index.html"
#     not_found_page   = "index.html"
#   }
# }

# resource "google_compute_backend_bucket" "kitchen-horse-web-us-central1" {
#   name        = "kitchen-horse-web-us-central1"
#   bucket_name = google_storage_bucket.kitchen-horse-web-us-central1.name
# }

# resource "google_storage_bucket_iam_member" "kitchen-horse-web-us-central1-public" {
#   bucket = google_storage_bucket.kitchen-horse-web-us-central1.name
#   role   = "roles/storage.objectViewer"

#   member = "allUsers"
# }



resource "google_storage_bucket" "kitchen-horse-web" {
  name     = "kitchen-horse-web"
  location = "US"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
}

resource "google_compute_backend_bucket" "kitchen-horse-web" {
  name        = "kitchen-horse-web"
  bucket_name = google_storage_bucket.kitchen-horse-web.name
}

resource "google_storage_bucket_iam_member" "kitchen-horse-web-public" {
  bucket = google_storage_bucket.kitchen-horse-web.name
  role   = "roles/storage.objectViewer"

  member = "allUsers"
}

# resource "google_dns_record_set" "kitchen-horse" {
#   # TODO: statefile
#   project      = "central-259919"
#   name         = "kitchen.horse."
#   type         = "A"
#   ttl          = 300
#   managed_zone = "kitchen-horse"
#   rrdatas      = [google_compute_global_address.vault.address]
# }


resource "google_compute_managed_ssl_certificate" "kitchen-horse" {
  provider = google-beta
  name     = "kitchen-horse-201911400"
  managed {
    domains = ["kitchen.horse."]
  }
  lifecycle {
    create_before_destroy = true
  }
}
