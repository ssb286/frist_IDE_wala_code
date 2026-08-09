variable "nat" {}

data "azurerm_subnet" "subnet" {
  for_each             = var.nat
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_public_ip" "nat_pip" {
  for_each            = var.nat
  name                = "${each.value.name}-pip"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat" {
  for_each            = var.nat
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "nat_pip_assoc" {
  for_each             = var.nat
  nat_gateway_id       = azurerm_nat_gateway.nat[each.key].id
  public_ip_address_id = azurerm_public_ip.nat_pip[each.key].id
}

resource "azurerm_subnet_nat_gateway_association" "nat_subnet_assoc" {
  for_each       = var.nat
  subnet_id      = data.azurerm_subnet.subnet[each.key].id
  nat_gateway_id = azurerm_nat_gateway.nat[each.key].id
}

output "nat_gateway_id" {
  value = {
    for k, nat in azurerm_nat_gateway.nat :
    k => nat.id
  }
}
