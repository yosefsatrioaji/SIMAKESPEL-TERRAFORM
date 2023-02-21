resource "google_storage_bucket" "web-storage" {
  project                     = var.project_id
  name                        = "simakespelta-storage"
  location                    = "asia-southeast2"
  storage_class               = "REGIONAL"
  force_destroy               = false
  uniform_bucket_level_access = false
  cors {
    origin          = ["*"]
    method          = ["GET"]
    response_header = ["Content-Type"]
    max_age_seconds = 3600
  }
}

resource "google_storage_default_object_access_control" "public-rules" {
  bucket = google_storage_bucket.web-storage.name
  entity = "allUsers"
  role   = "READER"
}

resource "google_storage_bucket" "web-static" {
  project                     = var.project_id
  name                        = "simakespelta-static"
  location                    = "asia-southeast2"
  storage_class               = "REGIONAL"
  force_destroy               = false
  uniform_bucket_level_access = false
  cors {
    origin          = ["*"]
    method          = ["GET"]
    response_header = ["Content-Type"]
    max_age_seconds = 3600
  }
}

resource "google_storage_default_object_access_control" "public-rules-static" {
  bucket = google_storage_bucket.web-static.name
  entity = "allUsers"
  role   = "READER"
}
