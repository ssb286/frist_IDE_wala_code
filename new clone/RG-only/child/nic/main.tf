variable "nic" {}

data "azurerm_public_ip" "pip-ka-data-block" {
  for_each            = { for k, v in var.nic : k => v if lookup(v, "pip-ka-data-block", null) != null && lookup(v, "pip-ka-data-block", "") != "" }
  name                = each.value.pip-ka-data-block
  resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "subnet-ka-data-block" {
  for_each             = var.nic
  name                 = each.value.subnet-ka-data-block
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.nic
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.nameipconfig
    subnet_id                     = data.azurerm_subnet.subnet-ka-data-block[each.key].id
    public_ip_address_id          = contains(keys(data.azurerm_public_ip.pip-ka-data-block), each.key) ? data.azurerm_public_ip.pip-ka-data-block[each.key].id : null
    private_ip_address_allocation = "Dynamic"
  }
}

output "nic_id" {
  value = {
    for k, nic in azurerm_network_interface.nic :
    k => nic.id
  }
}
