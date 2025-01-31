# Resource Group
data "azurerm_resource_group" "rg" {
  name     = "rg-todo-dev"
}

resource "azurerm_container_registry" "acr" {
  
  name                     = "acrtodo${var.environment}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = var.location
  sku                      = "Basic"
  admin_enabled            = true
}


# Azure Kubernetes Service (AKS)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-todo-${var.environment}"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "aks-todo-${var.environment}"
  kubernetes_version  = "1.30"
  node_resource_group = "MC_${data.azurerm_resource_group.rg.name}_aks-todo-${var.environment}"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"  
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    Environment = var.environment
  }
}