resource "random_id" "instance_id" {
  byte_length = 8
}

resource "google_compute_instance" "default" {
  name         = "grafana-instance"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"

  

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

metadata_startup_script = "sudo apt-get install -y apt-transport-https && sudo apt-get update && sudo apt-get install -y apt-transport-https && sudo apt-get install -y software-properties-common wget && wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add - && echo 'deb https://packages.grafana.com/oss/deb stable main' | sudo tee -a /etc/apt/sources.list.d/grafana.list && sudo apt-get update && echo 'Y' | sudo apt-get install grafana && sudo systemctl daemon-reload && sudo systemctl start grafana-server && sudo systemctl status grafana-server && sudo grafana-cli plugins install simpod-json-datasource && grafana-cli plugins install doitintl-bigquery-datasource && sudo service grafana-server restart"

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server","allow-grafana-access"]
}

resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow-grafana-access" {
  name    = "allow-grafana-access"
  network = "default"
  
  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }
  
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-grafana-access"]
  
}



output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
