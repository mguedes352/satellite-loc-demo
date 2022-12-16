terraform {
 required_providers {
   ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.26.2"
    }
  }
}

############################
# Variables
############################

variable "ibmcloud_api_key" {
type        = string
  description = "API Key that will be used to create resources"
}

#variable "iaas_classic_username" {}
#variable "iaas_classic_api_key" {}

variable "region" {
 type        = string
  default     = "br-sao"
  description = "Check the Region you want to deploy your vpc"
}

variable "my_ssh_key_name" {
 type        = string
#  default     = "c614fb3fa03847269c5319ac3a197e04"
  description = "Your ssh key name"
}

variable "vpc_name" {
 type        = string
 default     = "ibm-demo"
 description = "Name for vpc"
}

variable "vpc_zone1" {
 type        = string
  default     = "br-sao-1"
  description = "Default zone 1 for br-sao"
}

variable "vpc_zone2" {
 type        = string
  default     = "br-sao-2"
  description = "Default zone 1 for br-sao"
}

variable "vpc_zone3" {
 type        = string
  default     = "br-sao-3"
  description = "Default zone 3 for br-sao"

}

variable "res_group" {
  type        = string
  default     = "c614fb3fa03847269c5319ac3a197e04"
  description = "Default Resource Group is RG-Tadeu"
}

variable "os_version" {
  type        = string
  default     = "ibm-centos-7-9-minimal-amd64-7"
  description = "Check the OS versions available for VPC VSIs"
}

variable "profile"{
 type        = string
  default     = "bx2-4x16"
  description = "Check the profiles available for VPC VSIs"
}
 
 


############################
#        DATA
############################

#data "ibm_is_image" "name" {
#  name = var.os_version
 
#locals {
#  image_id    = data.ibm_is_image.name.id
#}

############################
# Configure the IBM Provider
############################

provider "ibm" {
  ibmcloud_api_key    = var.ibmcloud_api_key
  #iaas_classic_username = var.iaas_classic_username
  #iaas_classic_api_key  = var.iaas_classic_api_key
  region = var.region
}

############################
# Create a VPC with VSI
############################

# Locals and variables
locals {
   BASENAME = var.vpc_name
   ZONE     = var.vpc_zone1
   ZONE2    = var.vpc_zone2
   ZONE3    = var.vpc_zone3
}

# Existing SSH key can be provided
data "ibm_is_ssh_key" "ssh_key_id" {
   name = var.my_ssh_key_name
}

############################
# Virtual Private Cloud
############################

# Virtual Private Cloud
resource "ibm_is_vpc" "vpc-instance" {
  name = "${local.BASENAME}-vpc"
  
}

# Security group
resource "ibm_is_security_group" "sg1" {
   name = "${local.BASENAME}-sg1"
   vpc  = ibm_is_vpc.vpc-instance.id
   resource_group = var.res_group
}

# allow all incoming network traffic
resource "ibm_is_security_group_rule" "example-ingress_ssh_all" {
   group     = ibm_is_security_group.sg1.id
   direction = "inbound"
}

# Subnet 
resource "ibm_is_subnet" "subnet1" {
   name                     = "${local.BASENAME}-subnet1"
   vpc                      = ibm_is_vpc.vpc-instance.id
   zone                     = local.ZONE
   total_ipv4_address_count = 128
   resource_group = var.res_group
}

# Subnet 2
resource "ibm_is_subnet" "subnet2" {
   name                     = "${local.BASENAME}-subnet2"
   vpc                      = ibm_is_vpc.vpc-instance.id
   zone                     = local.ZONE2
   total_ipv4_address_count = 128
   resource_group = var.res_group
}

# Subnet 3
resource "ibm_is_subnet" "subnet3" {
   name                     = "${local.BASENAME}-subnet3"
   vpc                      = ibm_is_vpc.vpc-instance.id
   zone                     = local.ZONE3
   total_ipv4_address_count = 128
   resource_group = var.res_group
}


############################
# Virtual Servicer Instance
############################

# Image for Virtual Server Insance
 data "ibm_is_image" "name" {
 name = var.os_version
}


# Virtual Server Insance 1
resource "ibm_is_instance" "vsi1" {
   name    = "${local.BASENAME}-vsi1"
   vpc     = ibm_is_vpc.vpc-instance.id
   keys    = [data.ibm_is_ssh_key.ssh_key_id.id]
   zone    = local.ZONE
   image   = data.ibm_is_image.name.id 
   profile = var.profile
   resource_group = var.res_group
   
   # References to the subnet and security groups
   primary_network_interface {
     subnet          = ibm_is_subnet.subnet1.id
     security_groups = [ibm_is_security_group.sg1.id]
   }
}

# Request a foaling ip 
resource "ibm_is_floating_ip" "fip1" {
   name   = "${local.BASENAME}-fip1"
   target = ibm_is_instance.vsi1.primary_network_interface[0].id
   resource_group = var.res_group
 
}

# Virtual Server Insance 2
resource "ibm_is_instance" "vsi2" {
   name    = "${local.BASENAME}-vsi2"
   vpc     = ibm_is_vpc.vpc-instance.id
   keys    = [data.ibm_is_ssh_key.ssh_key_id.id]
   zone    = local.ZONE2
   image   = data.ibm_is_image.name.id 
   profile = var.profile
   resource_group = var.res_group
  
   
   # References to the subnet and security groups
   primary_network_interface {
     subnet          = ibm_is_subnet.subnet2.id
     security_groups = [ibm_is_security_group.sg1.id]
   }
}

# Request a foaling ip 
resource "ibm_is_floating_ip" "fip2" {
   name   = "${local.BASENAME}-fip2"
   target = ibm_is_instance.vsi2.primary_network_interface[0].id
   resource_group = var.res_group
  
}

# Virtual Server Insance 3
resource "ibm_is_instance" "vsi3" {
   name    = "${local.BASENAME}-vsi3"
   vpc     = ibm_is_vpc.vpc-instance.id
   keys    = [data.ibm_is_ssh_key.ssh_key_id.id]
   zone    = local.ZONE3
  image   = data.ibm_is_image.name.id 
   profile = var.profile
   resource_group = var.res_group
  
   
   # References to the subnet and security groups
   primary_network_interface {
     subnet          = ibm_is_subnet.subnet3.id
     security_groups = [ibm_is_security_group.sg1.id]
   }
}

# Request a foaling ip 
resource "ibm_is_floating_ip" "fip3" {
   name   = "${local.BASENAME}-fip3"
   target = ibm_is_instance.vsi3.primary_network_interface[0].id
   resource_group = var.res_group
  
}

# Virtual Server Insance 4
resource "ibm_is_instance" "vsi4" {
   name    = "${local.BASENAME}-vsi4"
   vpc     = ibm_is_vpc.vpc-instance.id
   keys    = [data.ibm_is_ssh_key.ssh_key_id.id]
   zone    = local.ZONE
   image   = data.ibm_is_image.name.id 
   profile = var.profile
   resource_group = var.res_group

   
   # References to the subnet and security groups
   primary_network_interface {
     subnet          = ibm_is_subnet.subnet1.id
     security_groups = [ibm_is_security_group.sg1.id]
   }
}

# Request a foaling ip 
resource "ibm_is_floating_ip" "fip4" {
   name   = "${local.BASENAME}-fip4"
   target = ibm_is_instance.vsi4.primary_network_interface[0].id
   resource_group = var.res_group
  
}

# Virtual Server Insance 5
resource "ibm_is_instance" "vsi5" {
   name    = "${local.BASENAME}-vsi5"
   vpc     = ibm_is_vpc.vpc-instance.id
   keys    = [data.ibm_is_ssh_key.ssh_key_id.id]
   zone    = local.ZONE2
   image   = data.ibm_is_image.name.id 
   profile = var.profile
   resource_group = var.res_group

   
   # References to the subnet and security groups
   primary_network_interface {
     subnet          = ibm_is_subnet.subnet2.id
     security_groups = [ibm_is_security_group.sg1.id]
   }
}

# Request a foaling ip 
resource "ibm_is_floating_ip" "fip5" {
   name   = "${local.BASENAME}-fip5"
   target = ibm_is_instance.vsi5.primary_network_interface[0].id
   resource_group = var.res_group

}

# Virtual Server Insance 6
resource "ibm_is_instance" "vsi6" {
   name    = "${local.BASENAME}-vsi6"
   vpc     = ibm_is_vpc.vpc-instance.id
   keys    = [data.ibm_is_ssh_key.ssh_key_id.id]
   zone    = local.ZONE3
   image   = data.ibm_is_image.name.id 
   profile = var.profile
   resource_group = var.res_group

   
   # References to the subnet and security groups
   primary_network_interface {
     subnet          = ibm_is_subnet.subnet3.id
     security_groups = [ibm_is_security_group.sg1.id]
   }
}

# Request a foaling ip 
resource "ibm_is_floating_ip" "fip6" {
   name   = "${local.BASENAME}-fip6"
   target = ibm_is_instance.vsi6.primary_network_interface[0].id
   resource_group = var.res_group
 
}

# Try to logon to the Virtual Service Instance
#output "sshcommand" {
#   value = "ssh root@ibm_is_floating_ip.fip1.address"
#}
