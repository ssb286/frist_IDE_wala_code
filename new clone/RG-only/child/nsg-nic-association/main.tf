resource "azurerm_network_interface_security_group_association" "association" {
  for_each = var.nsg-nic-association

  network_interface_id      = var.nic_id[each.value.nic]
  network_security_group_id = var.nsg_id[each.value.nsg]
}

variable "nic_id" {}
variable "nsg_id" {}
variable "nsg-nic-association" {}