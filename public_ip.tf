resource "azurerm_public_ip" "pip" {
  count               = var.vm_count
  name                = "myPublicIP${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}