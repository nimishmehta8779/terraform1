resource "azurerm_network_security_group" "NMSecurityGroup" {
    name = "NMSecurityGroup"
    location = "West US"
    resource_group_name = "${azurerm_resource_group.nmresourcegroup.name}"
}

resource "azurerm_network_security_rule" "sshRule" {
    name = "sshRule"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    resource_group_name = "${azurerm_resource_group.nmresourcegroup.name}"
    network_security_group_name = "${azurerm_network_security_group.NMSecurityGroup.name}"
}