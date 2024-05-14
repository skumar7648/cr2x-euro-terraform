resource "azurerm_linux_virtual_machine" "cr2xvirtualmachines" {
  name = "cr2x-vm1"
  resource_group_name = azurerm_resource_group.cr2xgroups.name
  location            = azurerm_resource_group.cr2xgroups.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Password@1234"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.cr2xnic.id ]
  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

