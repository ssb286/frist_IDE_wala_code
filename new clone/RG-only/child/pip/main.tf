variable "pip" {}

resource "azurerm_public_ip" "pip" {
  for_each            = var.pip
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

output "pip_id" {
  value = {
    for k, pip in azurerm_public_ip.pip :
    k => pip.id
  }
}