# Create a virtual network in the web_servers resource group
# This is a test file
resource "azurerm_virtual_network" "NMNetwork" {
  name                = "NMNetwork"
  address_space       = ["172.25.0.0/16"]
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.nmresourcegroup.name}"
}

resource "azurerm_subnet" "NMSubnet1" {
  name                 = "NMSubnet1"
  resource_group_name  = "${azurerm_resource_group.nmresourcegroup.name}"
  virtual_network_name = "${azurerm_virtual_network.NMNetwork.name}"
  address_prefix       = "172.25.1.0/24"
}

resource "azurerm_subnet" "NMSubnet2" {
  name                 = "NMSubnet2"
  resource_group_name  = "${azurerm_resource_group.nmresourcegroup.name}"
  virtual_network_name = "${azurerm_virtual_network.NMNetwork.name}"
  address_prefix       = "172.25.2.0/24"
}