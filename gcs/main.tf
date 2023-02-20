resource "google_storage_bucket" "web-storage" {
    project = "${var.project_id}"
    name = "simakespelta-storage"
    location = "asia-southeast2"
    storage_class = "REGIONAL"
    force_destroy = false
    uniform_bucket_level_access = true
}

resource "google_storage_default_object_access_control" "public-rules" {
    bucket = google_storage_bucket.web-storage.name
    entity = "allUsers"
    role = "READER"
}