# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-todo-${var.environment}"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  
  name                     = "acr-todo-${var.environment}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  sku                      = "Basic"
  admin_enabled            = true
}


# Azure Kubernetes Service (AKS)
module "aks" {
  source  = "Azure/aks/azurerm"
  version = "9.3.0"

  cluster_name = "aks-todo-list-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

}