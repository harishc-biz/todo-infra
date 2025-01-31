
output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.resource_group.name
}

output "acr_name" {
  description = "The name of the Azure Container Registry"
  value       = module.acr.name
}

output "aks_name" {
  description = "The name of the AKS cluster"
  value       = module.aks.name
}

output "aks_kube_config" {
  description = "The kubeconfig for the AKS cluster"
  value       = module.aks.kube_config
  sensitive   = true
}