output "ue1_out_public_subnet_name" {
  value       = google_compute_subnetwork.public_subnet.subnetwork
  description = "The URI of the VPC network-01"
}


output "ue1_out_private_subnet_name" {
  value       = google_compute_subnetwork.private_subnet.subnetwork
  description = "The URI of the VPC network-01"
}

