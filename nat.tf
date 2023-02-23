resource "google_compute_router" "router" {
  name    = "my-router"
  region  = google_compute_subnetwork.management.region
  network = google_compute_network.vpc-network.id

  bgp {
    asn = 64514
  }
}
resource "google_compute_router_nat" "nat" {
  name = "nat-router"
  router = google_compute_router.router.name
  region = google_compute_router.router.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"  
  # subnetwork {
  #   name="management"
  #   source_ip_ranges_to_nat = ["ALL_IP_RANGES"]

  # }

}
