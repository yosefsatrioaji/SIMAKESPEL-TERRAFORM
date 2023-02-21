module "vpc" {
  source     = "../backend/vpc"
  project_id = var.project_id
}

module "subnet" {
  source      = "../backend/subnet"
  project_id  = var.project_id
  region      = var.region
  vpc_name    = module.vpc.vpc_name
  subnet_cidr = var.subnet_cidr
}

module "firewall" {
  source        = "../backend/firewall"
  project_id    = var.project_id
  vpc_name      = module.vpc.vpc_name
  ip_cidr_range = module.subnet.ip_cidr_range
}

module "cloudsql" {
  source                     = "../cloudsql"
  project_id                 = var.project_id
  region                     = var.region
  availability_type          = var.availability_type
  sql_instance_size          = var.sql_instance_size
  sql_disk_type              = var.sql_disk_type
  sql_disk_size              = var.sql_disk_size
  sql_require_ssl            = var.sql_require_ssl
  sql_master_zone            = var.sql_master_zone
  sql_connect_retry_interval = var.sql_connect_retry_interval
  sql_replica_zone           = var.sql_replica_zone
  sql_user                   = var.sql_user
  sql_pass                   = var.sql_pass
  network_id                 = module.vpc.network_id
}

module "gke" {
  source                = "../gke"
  project_id            = var.project_id
  region                = var.region
  gke_node_machine_type = var.gke_node_machine_type
  gke_label             = var.gke_label
  node_version          = var.node_version
  min_master_version    = var.min_master_version
  subnet_name           = module.subnet.subnet_name
  gke_num_nodes         = var.gke_num_nodes
  vpc_name              = module.vpc.vpc_name
}

module "gcs" {
  source     = "../gcs"
  project_id = var.project_id
}
