# VPC (基盤)
resource "google_compute_network" "vpc_main" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# --- [Topic 8: for_each によるサブネット量産] ---
# JSの Array.forEach() と同じ考え方
resource "google_compute_subnetwork" "subnets" {
  # map型（連想配列）を回す
  for_each = {
    "public-01"  = "10.0.1.0/24"
    "public-02"  = "10.0.2.0/24"
    "private-01" = "10.0.10.0/24"
  }

  name          = "subnet-${each.key}"    # each.key は "public-01" など
  ip_cidr_range = each.value              # each.value は "10.0.1.0/24" など
  region        = var.region
  network       = google_compute_network.vpc_main.id
}

resource "google_compute_network" "vpc_main" {
  name                    = var.vpc_name
  auto_create_subnetworks = false

  # これがプロの防衛策
  lifecycle {
    prevent_destroy = true # 間違えて destroy してもエラーで止めてくれる
  }
}