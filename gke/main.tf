resource "google_container_cluster" "primary" {
  name = "gke-${terraform.workspace}-cluster"
  zone = "${var.region}-a"

  additional_zones = [
    "${var.region}-b",
    "${var.region}-c",
  ]

  //  region              = "${var.region}"
  min_master_version = "${var.min_master_version}"
  node_version       = "${var.node_version}"
  enable_legacy_abac = false
  initial_node_count = "${var.gke_num_nodes[terraform.workspace]}"
  network            = "${var.vpc_name}"
  subnetwork         = "${var.subnet_name}"

  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

    kubernetes_dashboard {
      disabled = false
    }
  }

  master_auth {
    username = "${var.gke_master_user}"
    password = "${var.gke_master_pass}"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      env = "${var.gke_label[terraform.workspace]}"
    }

    disk_size_gb = 10
    machine_type = "${var.gke_node_machine_type}"
    tags         = ["gke-node"]
  }
}