variable "nsg" {}

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsg
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}

output "nsg_id" {
  value = {
    for k, nsg in azurerm_network_security_group.nsg :
    k => nsg.id
  }
}