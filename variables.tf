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
  default     = "br-sao"
  description = "Check the Region you want to deploy your vpc"
}

variable "my_ssh_key_name" {
  type        = string
  default     = "ssh-rafael"
  description = "Existing ssh key name"
}

variable "vpc_name" {
  type        = string
  default     = "vpc-demo-satellite-rafael"
  description = "Name for VPC"
}

variable "res_group" {
  type        = string
  default     = "RG-Rafael"
  description = "Your Resource Group"
}

variable "os_version" {
  type        = string
  default     = "ibm-centos-7-9-minimal-amd64-7"
  description = "Check the OS versions available for VPC VSIs"
}

variable "profile" {
  type        = string
  default     = "bx2-4x16"
  description = "Check the profiles available for VPC VSIs"
}

variable "vsi_number" {
  type        = number
  default     = 1
  description = "Number of VSIs in each Zone"
}

variable "rocks_name" {
  type        = string
  default     = "rocks-demo-satellite"
  description = "Name of ROCKS Cluster"
}


# variable "zones" {
#   type = list(string)
#   //count = var.zones_number
#   default = ["br-sao-1", "br-sao-2", "br-sao-3"]
# }

# variable "vpc_zone1" {
#   default     = "br-sao-1"
#   description = "Default zone 1 for br-sao"
# }

# variable "vpc_zone2" {
#   default     = "br-sao-2"
#   description = "Default zone 1 for br-sao"
# }

# variable "vpc_zone3" {
#   default     = "br-sao-3"
#   description = "Default zone 3 for br-sao"

# }