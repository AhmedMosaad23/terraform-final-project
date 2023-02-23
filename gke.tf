resource "google_container_cluster" "primary" {
  name     = "primary"
  location = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count       = 1
  network = google_compute_network.vpc-network.id
  subnetwork = google_compute_subnetwork.restricted.id
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
  ip_allocation_policy {
    #cluster_ipv4_cidr_block = "172.16.0.0/22"
  }
  master_authorized_networks_config {
    cidr_blocks {
        cidr_block = "10.0.0.0/24"
        display_name = "management_subnet"
    }

  }
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write"
    ]
    service_account = google_service_account.gcp-my-service.email
  }
   
}

resource "google_container_node_pool" "node-pool" {
  name       = "node-pool"
  location   = "us-central1-a"
  cluster    = google_container_cluster.primary.id
  node_count = 1
  
  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    service_account = google_service_account.gcp-my-service.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    disk_size_gb = 100
  }
}