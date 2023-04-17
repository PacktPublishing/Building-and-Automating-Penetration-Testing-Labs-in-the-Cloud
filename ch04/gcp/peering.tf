locals = {
  net_01 = google_compute_network.vpc_01.self_link
  net_02 = google_compute_network.vpc_02.self_link
}

resource "google_compute_network_peering" "peer_01_to_02" {
  name         = "peer-01-to-02"
  network      = local.net_01
  peer_network = local.net_02
}

resource "google_compute_network_peering" "peer_02_to_01" {
  name         = "peer-02-to-01"
  network      = local.net_02
  peer_network = local.net_01
}

resource "google_compute_firewall" "allow-all-from-vpc2" {
  name    = "allow-all-from-vpc-2"
  network = local.net_01

  allow {
    protocol = "all"    
  }
  source_ranges = ["10.2.0.0/20"]
}

resource "google_compute_firewall" "allow-all-from-vpc1" {
  name    = "allow-all-from-vpc-1"
  network = local.net_02

  allow {
    protocol = "all"    
  }
  source_ranges = ["10.1.0.0/20"]
}
