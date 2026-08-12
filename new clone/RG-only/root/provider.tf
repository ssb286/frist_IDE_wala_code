terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 5.0.1"
    }
  }

  backend "azurerm" {
    resource_group_name  = "RG-Storage"
    storage_account_name = "sarvstorageforbackend"
    container_name       = "statefilestorage"
    key                  = "vmkeyvault.tfstate"
  }
}

provider "azurerm" {
  features {}
}