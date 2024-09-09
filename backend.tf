terraform {
  backend "azurerm" {
    resource_group_name   = "AzureResourceGroup"
    storage_account_name  = "azurestorageaccountbin"
    container_name        = "tfstate"
    key                   = "bin/terraform.tfstate"
  }
}
