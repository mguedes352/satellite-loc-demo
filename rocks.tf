############################
# ROCKS
############################

resource "ibm_container_vpc_cluster" "cluster" {
  name   = var.rocks_name
  flavor = var.profile_rocks
  vpc_id = data.ibm_is_vpc.vpc.id

  zones {
    name      = "${var.region}-1"
    subnet_id = ibm_is_subnet.subnets[0].id
  }
  zones {
    name      = "${var.region}-2"
    subnet_id = ibm_is_subnet.subnets[1].id
  }
  zones {
    name      = "${var.region}-3"
    subnet_id = ibm_is_subnet.subnets[2].id
  }


  /*****************
    OPTIONAL ARGUMENTS
    *****************/
  cos_instance_crn     = ibm_resource_instance.cos.id # REQUIRED FOR OPENSHIFT CLUSTERS
  kube_version         = "4.12.24_openshift"
  force_delete_storage = false
  wait_till            = "MasterNodeReady"
  worker_count         = 1
  resource_group_id    = data.ibm_resource_group.rg.id
  //tags                 = var.tag-rocks
}

