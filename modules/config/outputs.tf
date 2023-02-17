output "gcp_region" {
  value       = local.config["gcp"]["region"]
  description = "GCP Region"
}

output "gcp_project_ids" {
  value       = local.config["gcp"]["project_ids"]
  description = "GCP Project IDs mapped to workspaces"
}

output "gcp_numeric_project_ids" {
  value       = local.config["gcp"]["numeric_project_ids"]
  description = "GCP Numeric Project IDs mapped to workspaces"
}

output "gke_ids" {
  value       = local.config["gcp"]["gke_ids"]
  description = "GKE clusters IDs"
}

output "fqdn" {
  value       = local.config["fqdn"]
  description = "Domains mapped to workspaces"
}

output "common_labels" {
  value = {
    terraform   = true
    environment = terraform.workspace
  }
  description = "Reusable common labels"
}

output "org_id" {
  value       = local.config["gcp"]["org_id"]
  description = "GCP Organization ID"
}

