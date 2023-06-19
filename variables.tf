############################
# Variables
############################

variable "ibmcloud_api_key" {
  type        = string
  sensitive   = true
  description = "API Key that will be used to create resources"
}

variable "region" {
  type        = string
  default     = "us-south"
  description = "Check the Region you want to deploy your vpc"
}

variable "vpc_name" {
  type        = string
  default     = "vpc-demo-satellite"
  description = "Name for VPC"
}

variable "rocks_name" {
  type        = string
  default     = "rocks-demo-satellite"
  description = "Name of ROCKS Cluster"
}




variable "res_group" {
  type        = string
  default     = "RG-Demo-Satellite"
  description = "Your Resource Group"
}

variable "os_version" {
  type        = string
  default     = "ibm-redhat-9-0-minimal-amd64-2"
  description = "Check the OS versions available for VPC VSIs"
}

variable "profile" {
  type        = string
  default     = "bx2-4x16"
  description = "Profile available for VPC VSIs"
}

variable "profile_rocks" {
  type        = string
  default     = "bx2.16x64"
  description = "Profile available for ROCKS"
}


variable "vsi_number" {
  type        = number
  default     = 1
  description = "Number of VSIs in each Zone"
}

variable "my_ssh_key_name" {
  type        = string
  default     = "ssh-rafael-dal"
  description = "Existing ssh key name"
}
