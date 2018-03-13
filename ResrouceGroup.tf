# ResourceGroup.tf

resource "azurerm_resource_group" "nmresourcegroup" {
  name     = "nmresourcegroup"
  location = "West US"

  tags {
    environment = "Terraform Testing"
  }
}