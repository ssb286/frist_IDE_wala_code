variable "vnet" {}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet
  name                = each.value.name
  address_space       = each.value.address_space
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}

output "vnet_id" {
  value = {
    for k, vnet in azurerm_virtual_network.vnet :
    k => vnet.id
  }
}

