variable "bastion" {}

resource "azurerm_subnet" "bastion_subnet" {
  for_each             = var.bastion
  name                 = "AzureBastionSubnet"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.bastion_subnet_prefix
}

resource "azurerm_public_ip" "bastion_pip" {
  for_each            = var.bastion
  name                = "${each.value.name}-pip"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastion
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet[each.key].id
    public_ip_address_id = azurerm_public_ip.bastion_pip[each.key].id
  }
}

output "bastion_id" {
  value = {
    for k, b in azurerm_bastion_host.bastion :
    k => b.id
  }
}
