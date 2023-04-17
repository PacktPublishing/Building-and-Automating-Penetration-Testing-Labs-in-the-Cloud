resource "google_compute_project_metadata" "default" {
  metadata = {
    "serial-port-enable" = "TRUE"
  }
}

resource "google_compute_network" "vpc_01" {
  name = "vpc-01"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet_01" {
  name          = "subnet-01"
  ip_cidr_range = "10.1.0.0/20"
  region        = "us-central1"
  network       = google_compute_network.vpc_01.name
}

locals {
  script = "useradd ${local.vm_username}; echo ${local.vm_username}:${local.vm_password} | chpasswd; usermod -aG google-sudoers ${local.vm_username}"

  subnet_01 = google_compute_subnetwork.subnet_01.id
}

resource "google_compute_instance" "vm_01" {
  name         = "vm-01"
  machine_type = "f1-micro"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = local.script

  network_interface {
    subnetwork = local.subnet_01

    access_config {}
  }
}

locals {
    vm_01 = google_compute_instance.vm_01
    vm_01_ni = local.vm_01.network_interface.0
    vm_01_private_ip = local.vm_01_ni.network_ip
    vm_01_ac = local.vm_01_ni.access_config.0
    vm_01_public_ip = local.vm_01_ac.nat_ip
}

output "vm_01_private_ip" {
  value = local.vm_01_private_ip
}

output "vm_01_public_ip" {
  value = local.vm_01_public_ip
}
