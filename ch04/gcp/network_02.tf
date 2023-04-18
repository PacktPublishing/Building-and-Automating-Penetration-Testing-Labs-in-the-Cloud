resource "google_compute_network" "vpc_02" {
  name = "vpc-02"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet_02" {
  name          = "subnet-02"
  ip_cidr_range = "10.2.0.0/20"
  region        = "us-central1"
  network       = google_compute_network.vpc_02.name
}

resource "google_compute_instance" "vm_02" {
  name         = "vm-02"
  machine_type = "f1-micro"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = local.script

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_02.id

    access_config {}
  }
}

output "vm_02_private_ip" {
  value = google_compute_instance.vm_02.network_interface.0.network_ip
}

output "vm_02_public_ip" {
  value = google_compute_instance.vm_02.network_interface.0.access_config.0.nat_ip
}
