# Create a virtual network within the resource group
resource "azurerm_virtual_network" "cr2xvirtualnetwork" {
  name                = "cr2xnetwork1"
  resource_group_name = azurerm_resource_group.cr2xgroups.name
  location            = azurerm_resource_group.cr2xgroups.location
  address_space       = ["10.0.0.0/16"]
  }
resource "azurerm_subnet" "cr2xsubnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.cr2xgroups.name
  virtual_network_name = azurerm_virtual_network.cr2xvirtualnetwork.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "cr2xnic" {
  name                = "cr2xnic1"
  location            = azurerm_resource_group.cr2xgroups.location
  resource_group_name = azurerm_resource_group.cr2xgroups.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.cr2xsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.cr2xpublicip.id
  }
}
resource "azurerm_public_ip" "cr2xpublicip" {
  name                = "cr2xpublicip1"
  resource_group_name = azurerm_resource_group.cr2xgroups.name
  location            = azurerm_resource_group.cr2xgroups.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}