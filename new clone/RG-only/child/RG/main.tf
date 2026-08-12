variable "rg" {}
resource "azurerm_resource_group" "rg" {
  for_each = var.rg
  name     = each.value.name
  location = each.value.location
}

output "rg_id" {
  value = {
    for k, rg in azurerm_resource_group.rg :
    k => rg.id
  }
}