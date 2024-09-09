terraform {
  backend "azurerm" {
    resource_group_name   = "RG1"
    storage_account_name  = "azurestorageaccountbin"
    container_name        = "tfstate"
    key                   = "bin/terraform.tfstate"
  }
}
