module "config" {
  source = "../modules/config"
}

data "google_project" "project" {
  project_id = local.project_id
}