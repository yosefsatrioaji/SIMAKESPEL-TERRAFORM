resource "google_compute_firewall" "firewalli-int" {
  project = var.project_id
  name    = "${terraform.workspace}-firewall-int"
  network = var.vpc_name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443", "80", "443", "3306"]
  }

  allow {
    protocol = "udp"
  }

  source_ranges = ["${var.ip_cidr_range}"]
}

# Create a firewall rule that allows external SSH, ICMP, and HTTPS:
resource "google_compute_firewall" "firewalli-ext" {
  project = var.project_id
  name    = "${terraform.workspace}-firewall-ext"
  network = var.vpc_name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443", "80", "443", "3306"]
  }

  source_ranges = ["0.0.0.0/0"]
}
