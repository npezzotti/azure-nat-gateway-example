resource "azurerm_network_interface" "nic_ubn_01" {
  name                = "${random_id.example.id}_nic-01"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "${random_id.example.id}_nic-01-configuration"
    subnet_id                     = azurerm_subnet.nat.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  resource_group_name             = azurerm_resource_group.example.name
  name                            = "${random_id.example.id}-vm"
  location                        = azurerm_resource_group.example.location
  admin_username                  = "azureuser"
  admin_password                  = var.vm_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic_ubn_01.id]
  size                            = "Standard_DS1_v2"

  os_disk {
    name                 = "${random_id.example.id}-vm-disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
