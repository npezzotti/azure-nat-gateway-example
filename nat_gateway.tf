resource "azurerm_resource_group" "example" {
  name     = "${random_id.example.id}-rg"
  location = var.region
}

resource "azurerm_virtual_network" "example" {
  name                = "${random_id.example.id}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_public_ip" "example" {
  location            = azurerm_resource_group.example.location
  name                = "${random_id.example.id}-public-ip"
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "example" {
  name                    = "${random_id.example.id}-nat-gateway"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_nat_gateway_public_ip_association" "example" {
  nat_gateway_id       = azurerm_nat_gateway.example.id
  public_ip_address_id = azurerm_public_ip.example.id
}

resource "azurerm_subnet" "nat" {
  name                 = "${random_id.example.id}-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet_nat_gateway_association" "example" {
  subnet_id      = azurerm_subnet.nat.id
  nat_gateway_id = azurerm_nat_gateway.example.id
}
