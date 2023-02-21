# Create VPC
resource "google_compute_network" "vpc" {
  project                 = var.project_id
  name                    = "${terraform.workspace}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_global_address" "private-ip" {
  project       = var.project_id
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "private_vpc_network" {
  provider                = google-beta
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private-ip.name]
}
