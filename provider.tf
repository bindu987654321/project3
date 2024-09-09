terraform {
  required_providers {
    # Specify your provider here
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.0"
    }
    # Add other providers if needed
  }
}


provider "azurerm" {
  features {}
  skip_provider_registration = true
}
