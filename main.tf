variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "compartment_ocid" {}
variable "region" {}
variable "ssh_private_key_path" {}
variable "ssh_public_key_path" {}

# Choose an Availability Domain
variable "AD" {
  default = "1"
}

variable "InstanceShape" {
  default = "VM.Standard1.2"
}

variable "InstanceImageDisplayName" {
  default = "Oracle-Linux-7.4-2017.10.25-0"
}

variable "vcn_cidr" {
  default = "10.0.0.0/16"
}

variable "mgmt_subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.1.0/24"
}

provider "oci" {
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.ssh_private_key_path}"
  region           = "${var.region}"
}


resource "oci_core_virtual_network" "CoreVCN" {
  cidr_block     = "${var.vcn_cidr}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "lg-hello-vcn-tf"
}
