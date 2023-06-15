############################
# Subnets
############################

locals {
  ZONES = ["${var.region}-1", "${var.region}-2", "${var.region}-3"]
}

resource "ibm_is_subnet" "subnets" {
  count                    = 3
  name                     = "subnet-demo-satellite-${count.index + 1}"
  vpc                      = ibm_is_vpc.vpc-instance.id
  zone                     = local.ZONES[count.index]
  total_ipv4_address_count = 128
  resource_group           = data.ibm_resource_group.rg.id
}

