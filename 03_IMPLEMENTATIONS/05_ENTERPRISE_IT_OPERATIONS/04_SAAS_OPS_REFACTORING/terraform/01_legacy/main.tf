provider "google" {
  project = "terraform-sandbox-lab"
  region  = "asia-northeast1"
}

resource "google_bigquery_dataset" "legacy_ds" {
  dataset_id = "temp_ops_dataset"
  location   = "asia-northeast1"
  delete_contents_on_destroy = true
}

resource "google_bigquery_table" "legacy_tbl" {
  dataset_id = google_bigquery_dataset.legacy_ds.dataset_id
  table_id   = "legacy_tickets"
  schema     = "[{\"name\": \"id\", \"type\": \"STRING\"},{\"name\": \"title\", \"type\": \"STRING\"}]"
}

resource "google_project_iam_member" "dangerous_iam" {
  project = "terraform-sandbox-lab"
  role    = "roles/owner"
  member  = "serviceAccount:841765922679-compute@developer.gserviceaccount.com"
}
