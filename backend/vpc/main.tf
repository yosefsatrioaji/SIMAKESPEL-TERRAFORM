# Create VPC
resource "google_compute_network" "vpc" {
  project = "${var.project_id}"
  name                    = "${terraform.workspace}-vpc"
  auto_create_subnetworks = "false"
}