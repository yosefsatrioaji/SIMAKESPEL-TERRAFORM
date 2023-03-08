# Create Subnet

resource "google_compute_subnetwork" "subnet" {
  project       = var.project_id
  name          = "${terraform.workspace}-subnet"
  ip_cidr_range = var.subnet_cidr[terraform.workspace]
  network       = var.vpc_name
  region        = var.region
  secondary_ip_range {
    range_name    = "cluster-secondary-range"
    ip_cidr_range = "10.36.0.0/20"
  }
  secondary_ip_range {
    range_name    = "services-secondary-range"
    ip_cidr_range = "10.40.240.0/20"
  }
}
