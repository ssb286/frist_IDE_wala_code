variable "subnet" {}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet
  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}

output "subnet_id" {
  value = {
    for k, subnet in azurerm_subnet.subnet :
    k => subnet.id
  }
}
