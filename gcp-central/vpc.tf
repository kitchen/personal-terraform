resource "google_compute_shared_vpc_host_project" "central" {
  project = "central-259919"
}

resource "google_compute_network" "central" {
  name                    = "central"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "central-42" {
  name          = "central-42"
  network       = google_compute_network.central.self_link
  ip_cidr_range = "10.42.32.0/20" # /20 that contains 10.42.42.42 :D
  region        = "us-central1"
}

resource "google_compute_router" "central" {
  name    = "central"
  network = google_compute_network.central.name
}

resource "google_compute_router_nat" "central" {
  name                               = "central"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  router                             = google_compute_router.central.name
}

resource "google_compute_subnetwork_iam_member" "vault-instance-central-42" {
  # TODO: statefile
  project    = "central-259919"
  region     = "us-central1"
  subnetwork = "central-42"
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:311763859367@cloudservices.gserviceaccount.com"
}

resource "google_compute_firewall" "central-allow-ssh" {
  name    = "central-allow-ssh"
  network = google_compute_network.central.name

  allow {
    # TODO: filter this so it's just from IAP IPs
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "central-allow-http" {
  name    = "central-allow-http"
  network = google_compute_network.central.name

  allow {
    # TODO: filter this so it's just from forwarder IPs
    protocol = "tcp"
    ports    = ["80"]
  }
}
