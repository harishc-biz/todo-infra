variable "environment" {
  description = "The environment (dev, qa, prod)"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "container_name" {
  description = "The name of the container"
  type        = string
}

variable "key" {
  description = "The key for the state file"
  type        = string
}

