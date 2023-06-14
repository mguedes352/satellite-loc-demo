############################
# COS
############################


resource "ibm_resource_instance" "cos" {
  name              = "cos-demo-satellite"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = data.ibm_resource_group.rg.id
  //tags              = ["tag1", "tag2"]


  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}
