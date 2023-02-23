resource "google_compute_network" "vpc-network" {
  name = "vpc-network"
  auto_create_subnetworks = false
  routing_mode = "REGIONAL" 
  delete_default_routes_on_create = false

}
