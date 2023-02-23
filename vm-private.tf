resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  #tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }
    
  // Local SSD disk
  # scratch_disk {
  #   interface = "SCSI"
  # }

  network_interface {
    network = google_compute_network.vpc-network.id
    subnetwork = google_compute_subnetwork.management.id
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.instance-sa.email
    scopes = ["cloud-platform",
    "https://www.googleapis.com/auth/devstorage.read_only"
    ]
  }
  metadata_startup_script = file("script.sh")
}