output "nic-ka-op" {
  value = module.nic.nic_id["nic1"]
}
output "nsg-ka-op" {
  value = module.nsg.nsg_id["nsg1"]
}
output "lb-ka-op" {
  value = module.lb.lb_id["lb1"]
}
output "vm-op" {
  value = module.vm.vm_id
}
output "nat-op" {
  value = module.nat.nat_gateway_id
}
output "bastion-op" {
  value = module.bastion.bastion_id
}