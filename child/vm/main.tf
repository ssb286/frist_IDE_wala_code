variable "vm" {}
variable "nic_id" {}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vm
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = lookup(each.value, "size", "Standard_D2s_v3")
  admin_username                  = lookup(each.value, "admin_username", "adminuser")
  admin_password                  = lookup(each.value, "admin_password", "Password1234!")
  disable_password_authentication = false

  network_interface_ids = [
    var.nic_id[each.value.nic_key]
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

output "vm_id" {
  value = {
    for k, vm in azurerm_linux_virtual_machine.vm :
    k => vm.id
  }
}
