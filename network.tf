
resource "azurerm_virtual_network" "demovirtualnetwork" {
  name                = "terra-demo-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.demoresourcegroup.location
  resource_group_name = azurerm_resource_group.demoresourcegroup.name
}

resource "azurerm_subnet" "demosubnet" {
  name                 = "subnetabc"
  resource_group_name  = azurerm_resource_group.demoresourcegroup.name
  virtual_network_name = azurerm_virtual_network.demovirtualnetwork.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "demopublicip" {
  name                = "demolinuxmachine-pip"
  resource_group_name = azurerm_resource_group.demoresourcegroup.name
  location            = azurerm_resource_group.demoresourcegroup.location
  allocation_method   = "Static"

}