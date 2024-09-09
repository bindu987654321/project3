terraform {
  backend "azurerm" {
    resource_group_name   = "azurerm_resource_group.demoresourcegroup.name"
    storage_account_name  = "azurestorageaccountbin"
    container_name        = "tfstate"
    key                   = "bin/terraform.tfstate"
  }
}
