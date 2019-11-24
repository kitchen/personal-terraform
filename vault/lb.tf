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

  # TODO: IAP
  # iap {}

  backend {
    group = google_compute_instance_group_manager.vault.instance_group
  }
}
## target pool
## global address


# dns record



# ssl certificate
resource "google_compute_managed_ssl_certificate" "vault-kitchen-horse" {
  provider = google-beta
  name     = "vault-kitchen-horse"
  managed {
    domains = ["vault.kitchen.horse."]
  }

}
