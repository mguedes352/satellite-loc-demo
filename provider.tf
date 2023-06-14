############################
# Configure the IBM Provider
############################

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  #iaas_classic_username = var.iaas_classic_username
  #iaas_classic_api_key  = var.iaas_classic_api_key
  region = var.region
}

############################
# Data
############################

# Existing SSH key can be provided
data "ibm_is_ssh_key" "ssh_key" {
  name = var.my_ssh_key_name
}

data "ibm_resource_group" "rg" {
  name = var.res_group
}

# Image for Virtual Server Insance
data "ibm_is_image" "name" {
  name = var.os_version
}

data "ibm_is_vpc" "vpc" {
  name = ibm_is_vpc.vpc-instance.name
}

data "ibm_resource_instance" "cos" {
  name = ibm_resource_instance.cos.name
}

data "ibm_is_subnet" "subnets" {
  count = 3
  name  = ibm_is_subnet.subnets[count.index].name
}

data "ibm_is_public_gateway" "pg" {
  count = 3
  name  = ibm_is_public_gateway.pg[count.index].name
}


