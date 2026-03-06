# ルーター
resource "google_compute_router" "router" {
  name    = "nat-router"
  network = google_compute_network.vpc_main.id
  region  = var.region
}

# NAT本体
resource "google_compute_router_nat" "nat" {
  name                               = "nat-gateway"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}