resource "azurerm_public_ip" "NMPublicIp" {
    name = "NMPublicIp"
    location = "West US"
    resource_group_name = "${azurerm_resource_group.nmresourcegroup.name}"
    public_ip_address_allocation = "dynamic"

    tags {
        environment = "Terraform Testing"
    }
}

resource "azurerm_network_interface" "NMtestnic" {
    name = "NMtestnic"
    location = "West US"
    resource_group_name = "${azurerm_resource_group.nmresourcegroup.name}"
    network_security_group_id = "${azurerm_network_security_group.NMSecurityGroup.id}"

    ip_configuration {
        name = "NMconfiguration1"
        subnet_id = "${azurerm_subnet.NMSubnet1.id}"
        private_ip_address_allocation = "dynamic"
        public_ip_address_id = "${azurerm_public_ip.NMPublicIp.id}"
        
    }

}

# import an existing (generalised) vhd to create a managed disk.
resource "azurerm_managed_disk" "osdisk" {

  name                 = "NMosdisk1"
  location             = "West US"
  resource_group_name  = "nmresourcegroup"
  #os_type              = "linux"
  storage_account_type = "Standard_LRS"
  create_option        = "Import"
  source_uri           = "https://linuxspecializedvhd.blob.core.windows.net/vhd/smolabvlnx04-prep-for-azure-template-disk1-fixed.vhd"
  disk_size_gb         = "50"
}


resource "azurerm_virtual_machine" "NMvm1" {
    name = "NMvm1"
    location = "West US"
    resource_group_name = "${azurerm_resource_group.nmresourcegroup.name}"
    network_interface_ids = ["${azurerm_network_interface.NMtestnic.id}"]
    vm_size = "Basic_A1"

    storage_os_disk {
		name = "NMosdisk1"
        managed_disk_type = "Standard_LRS"
		managed_disk_id   = "${azurerm_managed_disk.osdisk.id}"
		disk_size_gb = "50"
		create_option = "Attach"
        os_type = "Linux"

    }
   
    tags {
        environment = "Terraform Testing"
    }
}