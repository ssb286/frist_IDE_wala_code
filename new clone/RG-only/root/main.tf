variable "rg" {}
variable "vnet" {}
variable "subnet" {}
variable "nic" {}
variable "pip" {}
variable "nsg" {}
variable "nsg-nic-association" {}
variable "lb" {}
variable "vm" {}
variable "nat" {}
variable "bastion" {}

module "rg" {
  source = "../child/RG"
  rg     = var.rg
}

module "vnet" {
  source     = "../child/vnet"
  vnet       = var.vnet
  depends_on = [module.rg]
}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../child/subnet"
  subnet     = var.subnet
}

module "nic" {
  depends_on = [module.subnet, module.pip]
  source     = "../child/nic"
  nic        = var.nic
}

module "pip" {
  depends_on = [module.rg]
  source     = "../child/pip"
  pip        = var.pip
}

module "nsg" {
  depends_on = [module.rg]
  source     = "../child/nsg"
  nsg        = var.nsg
}

module "nic-nsg" {
  source              = "../child/nsg-nic-association"
  nic_id              = module.nic.nic_id
  nsg_id              = module.nsg.nsg_id
  nsg-nic-association = var.nsg-nic-association
}

module "lb" {
  depends_on = [module.pip]
  source     = "../child/lb"
  lb         = var.lb
}

module "nat" {
  depends_on = [module.subnet]
  source     = "../child/nat"
  nat        = var.nat
}

module "vm" {
  depends_on = [module.nic]
  source     = "../child/vm"
  vm         = var.vm
  nic_id     = module.nic.nic_id
}

module "bastion" {
  depends_on = [module.vnet]
  source     = "../child/bastion"
  bastion    = var.bastion
}