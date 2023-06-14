############################
# Zones
############################

locals {
  ZONE1 = "${var.region}-1"
  ZONE2 = "${var.region}-2"
  ZONE3 = "${var.region}-3"
}


############################
# Virtual Servicer Instance
############################

# VSIs in subnet1
resource "ibm_is_instance" "vsi1" {

  count          = var.vsi_number
  name           = "vsi-subnet1-00${count.index}"
  vpc            = ibm_is_vpc.vpc-instance.id
  keys           = [data.ibm_is_ssh_key.ssh_key.id]
  zone           = local.ZONE1
  image          = data.ibm_is_image.name.id
  profile        = var.profile
  resource_group = data.ibm_resource_group.rg.id

  # References to the subnet and security groups
  primary_network_interface {
    subnet          = ibm_is_subnet.subnets[0].id
    security_groups = [ibm_is_security_group.sg1.id]
  }
}

# VSIs in subnet2
resource "ibm_is_instance" "vsi2" {

  count = var.vsi_number

  name           = "vsi-subnet2-00${count.index}"
  vpc            = ibm_is_vpc.vpc-instance.id
  keys           = [data.ibm_is_ssh_key.ssh_key.id]
  zone           = local.ZONE2
  image          = data.ibm_is_image.name.id
  profile        = var.profile
  resource_group = data.ibm_resource_group.rg.id

  # References to the subnet and security groups
  primary_network_interface {
    subnet          = ibm_is_subnet.subnets[1].id
    security_groups = [ibm_is_security_group.sg1.id]
  }
}

# VSIs in subnet3
resource "ibm_is_instance" "vsi3" {

  count = var.vsi_number

  name           = "vsi-subnet3-00${count.index}"
  vpc            = ibm_is_vpc.vpc-instance.id
  keys           = [data.ibm_is_ssh_key.ssh_key.id]
  zone           = local.ZONE3
  image          = data.ibm_is_image.name.id
  profile        = var.profile
  resource_group = data.ibm_resource_group.rg.id

  # References to the subnet and security groups
  primary_network_interface {
    subnet          = ibm_is_subnet.subnets[2].id
    security_groups = [ibm_is_security_group.sg1.id]
  }

}









