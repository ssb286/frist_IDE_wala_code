variable "lb" {}

data "azurerm_public_ip" "pip" {
  for_each            = var.lb
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_lb" "lb" {
  for_each            = var.lb
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = each.value.frontend_name
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
  }
}

output "lb_id" {
  value = {
    for k, lb in azurerm_lb.lb :
    k => lb.id
  }
}
