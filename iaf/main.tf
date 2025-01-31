provider "azurerm" {
  features {}
}

# Resource Group
module "resource_group" {
  source  = "azurerm/resources/azurerm"
  version = "3.0.0"

  name     = "rg-todo-${var.environment}"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  
  name                     = "acr-todo-${var.environment}"
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  sku                      = "Basic"
  admin_enabled            = true
}


# Azure Kubernetes Service (AKS)
module "aks" {
  source  = "Azure/aks/azurerm"
  version = "9.3.0"

  cluster_name = "aks-todo-list-${var.environment}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

}