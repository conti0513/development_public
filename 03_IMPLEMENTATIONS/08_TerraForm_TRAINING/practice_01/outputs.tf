output "vpc_self_link" {
  value = google_compute_network.vpc_main.self_link
}

output "subnet_ips" {
  value = { for k, v in google_compute_subnetwork.subnets : k => v.ip_cidr_range }
}