resource "google_compute_instance" "default" {
  name         = "${format("%s","${var.company}-${var.env}-${var.region_map["${var.var_region_name}"]}-instance1")}"
  machine_type  = "n1-standard-1"
  #zone         =   "${element(var.var_zones, count.index)}"
  zone          =   "${format("%s","${var.var_region_name}-b")}"
  tags          = ["ssh","http"]
  boot_disk {
    initialize_params {
      image     =  "centos-7-v20180129"     
    }
}

network_interface {
    subnetwork = "${google_compute_subnetwork.public_subnet.name}"
    access_config {
      // Ephemeral IP
    }
  }
}
