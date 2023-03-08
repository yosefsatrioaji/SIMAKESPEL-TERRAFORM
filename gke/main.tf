resource "google_container_cluster" "primary" {
  project      = var.project_id
  name         = "gke-simakespelta-cluster"
  node_version = var.node_version
  location     = "${var.region}"
  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = 3
      maximum       = 6
    }
    resource_limits {
      resource_type = "memory"
      minimum       = 11
      maximum       = 24
    }
  }

  min_master_version = var.min_master_version
  enable_legacy_abac = false
  initial_node_count = var.gke_num_nodes[terraform.workspace]
  network            = var.vpc_name
  subnetwork         = var.subnet_name
  networking_mode    = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_secondary_range_name  = "cluster-secondary-range"
    services_secondary_range_name = "services-secondary-range"
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  master_auth {
    #   username = "${var.gke_master_user}"
    #   password = "${var.gke_master_pass}"
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    disk_size_gb = 10
    machine_type = var.gke_node_machine_type
    tags         = ["gke-node"]
  }
}
