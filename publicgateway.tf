
locals {
  ZONES_ = ["${var.region}-1", "${var.region}-2", "${var.region}-3"]
}

resource "ibm_is_public_gateway" "pg" {
  count = 3
  name  = "public-gateway-${count.index + 1}"
  vpc   = ibm_is_vpc.vpc-instance.id
  zone  = local.ZONES_[count.index]
}


resource "ibm_is_subnet_public_gateway_attachment" "pg-attach" {
  count          = 3
  subnet         = data.ibm_is_subnet.subnets[count.index].id
  public_gateway = data.ibm_is_public_gateway.pg[count.index].id
}