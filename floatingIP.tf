############################
# Floating Ips
############################

#Request a floating ip for VSIs in Subnet 1
resource "ibm_is_floating_ip" "fip1" {
  count          = var.vsi_number
  name           = "fip-${ibm_is_instance.vsi1[count.index].name}"
  target         = ibm_is_instance.vsi1[count.index].primary_network_interface[0].id
  resource_group = data.ibm_resource_group.rg.id
}

#Request a floating ip for VSIs in Subnet 2
resource "ibm_is_floating_ip" "fip2" {
  count          = var.vsi_number
  name           = "fip-${ibm_is_instance.vsi2[count.index].name}"
  target         = ibm_is_instance.vsi2[count.index].primary_network_interface[0].id
  resource_group = data.ibm_resource_group.rg.id
}

#Request a floating ip for VSIs in Subnet 3
resource "ibm_is_floating_ip" "fip3" {
  count          = var.vsi_number
  name           = "fip-${ibm_is_instance.vsi3[count.index].name}"
  target         = ibm_is_instance.vsi3[count.index].primary_network_interface[0].id
  resource_group = data.ibm_resource_group.rg.id
}
