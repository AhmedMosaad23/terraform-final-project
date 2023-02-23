#--------------mangment-subnet-------------
resource "google_compute_subnetwork" "management" {
    name="management"
    ip_cidr_range = "10.0.0.0/24"
    region = "us-central1"
    network = google_compute_network.vpc-network.id
    private_ip_google_access = "true"
}
#--------------restricted-subnet-------------
resource "google_compute_subnetwork" "restricted" {
  name = "restricted"
  ip_cidr_range = "10.0.1.0/24"
  region = "us-central1"
  network = google_compute_network.vpc-network.id
  private_ip_google_access = "true"
  secondary_ip_range {
    range_name = "pods"
    ip_cidr_range = "10.48.0.0/14"
  }
  # secondary_ip_range {
  #   range_name = "service"
  #   ip_cidr_range = "10.52.0.0/20"
  # }

}
#---------------
resource "google_compute_firewall" "ssh" {
  name    = "ssh"
  network = google_compute_network.vpc-network.name
  
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "http" {
  name    = "http"
  network = google_compute_network.vpc-network.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
}