variable "company" {
  description = "The subnet ID from the network module"
  type = string
}

variable "env" {
  description = "The subnet ID from the network module"
  type = string
}

variable "var_ue1_private_subnet" {
   type = string 
  }

variable "var_ue1_public_subnet" {
   type = string 
  }  

variable "subnetwork1" {
   type = string 
  }

variable "network_self_link" {
   type = string 
  }  

variable "var_region_name" {
  default = "us-east1"
}

variable "region_map" {
  type = "map"
  default = {
    us-central1 = "us-central1"
  }
}
