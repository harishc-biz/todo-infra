provider "azurerm" {
  features {}
}

# Resource Group
module "resource_group" {
  source  = "azurerm/resources/azurerm"
  version = "3.0.0"

  name     = "rg-todo-list-${var.environment}"
  location = var.location
}

# Azure Container Registry (ACR)
module "acr" {
  source  = "azurerm/container-registry/azurerm"
  version = "3.0.0"

  name                = "acrtodolist${var.environment}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku                 = "Standard"
  admin_enabled       = true
}

# Virtual Network
module "vnet" {
  source  = "azurerm/virtual-network/azurerm"
  version = "3.0.0"

  name                = "vnet-todo-list-${var.environment}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  address_space       = ["10.0.0.0/16"]
}

# Subnet for AKS
module "subnet" {
  source  = "azurerm/subnet/azurerm"
  version = "3.0.0"

  name                 = "snet-aks-${var.environment}"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Azure Kubernetes Service (AKS)
module "aks" {
  source  = "azurerm/aks/azurerm"
  version = "5.0.0"

  name                = "aks-todo-list-${var.environment}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  dns_prefix          = "aks-todo-list-${var.environment}"

  default_node_pool = {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.0.2.0/24"
    dns_service_ip = "10.0.2.10"
  }

  depends_on = [
    module.subnet
  ]
}