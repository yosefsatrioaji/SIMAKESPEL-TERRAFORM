output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "The unique name of the network"
}

output "self_link" {
  value       = google_compute_network.vpc.self_link
  description = "The URL of the created resource"
}

variable "project_id" {
  description = "Project ID"
}

output "network_id" {
  value       = google_compute_network.vpc.id
  description = "The unique identifier for the resource"
}
