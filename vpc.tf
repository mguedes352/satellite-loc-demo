############################
# Virtual Private Cloud
############################

# Create VPC
resource "ibm_is_vpc" "vpc-instance" {
  name           = var.vpc_name
  resource_group = data.ibm_resource_group.rg.id
}
