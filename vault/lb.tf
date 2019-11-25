# load balancer
## forwarding rule
## health check
resource "google_compute_health_check" "vault-http" {
  name               = "vault-http"
  check_interval_sec = 10
  timeout_sec        = 2
  http_health_check {
    request_path = "/v1/sys/health"
  }

}

resource "google_compute_backend_service" "vault-http" {
  name          = "vault-http"
  health_checks = [google_compute_health_check.vault-http.self_link]

  iap {
    oauth2_client_id     = data.google_kms_secret.vault-http-client-id.plaintext
    oauth2_client_secret = data.google_kms_secret.vault-http-client-secret.plaintext
  }

  backend {
    group = google_compute_instance_group_manager.vault.instance_group
  }
}

# http proxy
resource "google_compute_target_http_proxy" "vault" {
  name    = "vault"
  url_map = google_compute_url_map.vault.self_link
}

# https proxy
resource "google_compute_target_https_proxy" "vault" {
  name    = "vault"
  url_map = google_compute_url_map.vault.self_link
  ssl_certificates = [
    google_compute_managed_ssl_certificate.vault-kitchen-horse.self_link,
    google_compute_managed_ssl_certificate.kitchen-horse.self_link
  ]
}

resource "google_compute_global_address" "vault" {
  name = "vault"
}

resource "google_compute_global_forwarding_rule" "vault-http" {
  name       = "vault-http"
  target     = google_compute_target_http_proxy.vault.self_link
  port_range = "80"
  ip_address = google_compute_global_address.vault.address
}

resource "google_compute_global_forwarding_rule" "vault-https" {
  name       = "vault-https"
  target     = google_compute_target_https_proxy.vault.self_link
  port_range = "443"
  ip_address = google_compute_global_address.vault.address
}


# urlmap
resource "google_compute_url_map" "vault" {
  name            = "vault"
  description     = "url mapping for vault"
  default_service = google_compute_backend_bucket.kitchen-horse-web.self_link

  host_rule {
    description  = "vault.kitchen.horse"
    hosts        = ["vault.kitchen.horse"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.vault-http.self_link
    description     = "all paths"
  }
}

resource "google_iap_web_backend_service_iam_binding" "vault-iap-kitchen" {
  web_backend_service = google_compute_backend_service.vault-http.name
  role                = "roles/iap.httpsResourceAccessor"
  members = [
    "user:kitchen@scriptkitchen.com"
  ]
}



# ssl certificate
resource "google_compute_managed_ssl_certificate" "vault-kitchen-horse" {
  provider = google-beta
  name     = "vault-kitchen-horse-201911400"
  managed {
    domains = ["vault.kitchen.horse."]
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_dns_record_set" "kitchen-horse-vault" {
  # TODO: statefile
  project      = "central-259919"
  name         = "vault.kitchen.horse."
  type         = "A"
  ttl          = 300
  managed_zone = "kitchen-horse"
  rrdatas      = [google_compute_global_address.vault.address]
}

data "google_kms_secret" "vault-http-client-id" {
  # TODO: remote state
  crypto_key = "projects/central-259919/locations/us-central1/keyRings/kitchen-secrets/cryptoKeys/secrets-key"
  ciphertext = "CiQAB8GTs2T2Rwvhz7KdiEG/YYMW7H8MIXGESRqp8lUWB1eRvO8ScQDJydJulX3ZRbutgHo2sM9p5hOhc7Cx/R/xt9nRlLJaLe7IezW2Yfo9J22hwNdjvIIpOXZoIYscLzqO31KV98oRdFybgrkSjNbG45vm0TQ/qEhhvZdP+wP3f8eCmzlZ6I3pTuVbk8RS7VaaLSxnCrDR"
}

data "google_kms_secret" "vault-http-client-secret" {
  # TODO: remote state
  crypto_key = "projects/central-259919/locations/us-central1/keyRings/kitchen-secrets/cryptoKeys/secrets-key"
  ciphertext = "CiQAB8GTs/D4bRRomZZT5oWM2Mtup0OFl1Ob6K08apfW7pQqe3sSQQDJydJuDNRkaWKqkP+uSVD3lzLbhr8ify4GFRIh4Yl6x56oJ2YgU4Biw9zZrwlJO6jaXDsQqTkd8QTB/O8SYuJ5"
}
