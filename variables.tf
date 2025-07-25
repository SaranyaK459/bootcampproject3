variable "environment" {
  description = "Selected environment (dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod"
  }
}

variable "backend_resource_group_name" {
  description = "Resource group name for backend Azure Storage"
  type        = map(string)
}

variable "backend_storage_account_name" {
  description = "Storage account name for backend state"
  type        = map(string)
}

variable "backend_container_name" {
  description = "Container name for backend state"
  type        = string
  default     = "tfstate"
}

variable "backend_key" {
  description = "Key name for backend terraform state file"
  type        = map(string)
}

variable "resource_group_name" {
  description = "Name of resource group"
  type        = map(string)
}

variable "location" {
  description = "Azure location"
  type        = map(string)
}

variable "vnet_cidr_prefix" {
  description = "CIDR prefix for the virtual network"
  type        = map(string)
}

variable "subnet1_cidr_prefix" {
  description = "CIDR prefix for the subnet"
  type        = map(string)
}

variable "vm_name" {
  description = "Windows VM name"
  type        = map(string)
}

variable "admin_username" {
  description = "Admin username for Windows VM"
  type        = map(string)
}

variable "admin_password" {
  description = "Admin password for Windows VM"
  type        = map(string)
  sensitive   = true
}

