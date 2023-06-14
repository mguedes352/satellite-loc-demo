############################
# Virtual Private Cloud
############################

# Create VPC
resource "ibm_is_vpc" "vpc-instance" {
  name = var.vpc_name
}
