rg = {
  rg1 = {
    name     = "rg1"
    location = "centralindia"
  }
}

vnet = {
  vnet1 = {
    name                = "vnet1"
    address_space       = ["10.0.0.0/16"]
    location            = "centralindia"
    resource_group_name = "rg1"
  }
}

subnet = {
  subnet1 = {
    name                 = "subnet1"
    resource_group_name  = "rg1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

pip = {
  pip1 = {
    name                = "pip1"
    resource_group_name = "rg1"
    location            = "centralindia"
  }
}

nic = {
  nic1 = {
    name                 = "nic1"
    location             = "centralindia"
    resource_group_name  = "rg1"
    nameipconfig         = "pip-ka-ipconfig"
    virtual_network_name = "vnet1"
    subnet-ka-data-block = "subnet1"
  }
  nic2 = {
    name                 = "nic2"
    location             = "centralindia"
    resource_group_name  = "rg1"
    nameipconfig         = "ipconfig-vm1"
    virtual_network_name = "vnet1"
    subnet-ka-data-block = "subnet1"
  }
  nic3 = {
    name                 = "nic3"
    location             = "centralindia"
    resource_group_name  = "rg1"
    nameipconfig         = "ipconfig-vm2"
    virtual_network_name = "vnet1"
    subnet-ka-data-block = "subnet1"
  }
}

nsg = {
  nsg1 = {
    name                = "nsg1"
    location            = "centralindia"
    resource_group_name = "rg1"
  }
}

nsg-nic-association = {
  assoc1 = {
    nic = "nic1"
    nsg = "nsg1"
  }
}

lb = {
  lb1 = {
    name                = "lb1"
    location            = "centralindia"
    resource_group_name = "rg1"
    pip_name            = "pip1"
    frontend_name       = "PublicIPAddress"
  }
}

vm = {
  vm1 = {
    name                = "vm1"
    location            = "centralindia"
    resource_group_name = "rg1"
    size                = "Standard_D2s_v3"
    nic_key             = "nic2"
    admin_username      = "adminuser"
    admin_password      = "Password1234!"
  }
  vm2 = {
    name                = "vm2"
    location            = "centralindia"
    resource_group_name = "rg1"
    size                = "Standard_D2s_v3"
    nic_key             = "nic3"
    admin_username      = "adminuser"
    admin_password      = "Password1234!"
  }
}

nat = {
  nat1 = {
    name                 = "nat-gateway1"
    location             = "centralindia"
    resource_group_name  = "rg1"
    virtual_network_name = "vnet1"
    subnet_name          = "subnet1"
  }
}

bastion = {
  bastion1 = {
    name                  = "bastion1"
    location              = "centralindia"
    resource_group_name   = "rg1"
    virtual_network_name  = "vnet1"
    bastion_subnet_prefix = ["10.0.1.0/26"]
  }
}
