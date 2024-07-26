resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/26"]
}

resource "azurerm_public_ip" "bastion" {
  resource_group_name = azurerm_resource_group.example.name
  name                = "${random_id.example.id}-bastion-public-ip"
  sku                 = "Standard"
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
}

resource "azurerm_bastion_host" "example" {
  name                = "${random_id.example.id}-bastion"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard"

  ip_configuration {
    name                 = "${random_id.example.id}-bastion-configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}
