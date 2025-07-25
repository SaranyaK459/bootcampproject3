terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.102.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = var.backend_resource_group_name[var.environment]
    storage_account_name = var.backend_storage_account_name[var.environment]
    container_name       = var.backend_container_name
    key                  = var.backend_key[var.environment]
  }
}

provider "azurerm" {
  features {}
  subscription_id = "d82fdb36-e398-48b3-b36b-d3520373269e"
  client_id       = "446a3948-8ab9-4ec5-9bd6-a3328f600132"
  client_secret   = "m_o8Q~83h1xnQFYHutAkVW4v0jf58glD14tGxc0Q"
  tenant_id       = "d9ef55f0-d1a8-4ed7-95d5-a51c583f7d5d"
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name[var.environment]
  location = var.location[var.environment]
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.environment}"
  address_space       = [var.vnet_cidr_prefix[var.environment]]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name                 = "subnet-${var.environment}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet1_cidr_prefix[var.environment]]
}

resource "azurerm_public_ip" "main" {
  name                = "public-ip-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "main" {
  name                = "nsg-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "main" {
  name                = "nic-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security
