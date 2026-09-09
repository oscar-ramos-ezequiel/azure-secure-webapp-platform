variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "rg-portfolio-webapp-dev-001"
}

variable "location" {
  description = "Azure region where resources are deployed"
  type        = string
  default     = "France Central"
}

variable "app_service_name" {
  description = "Name of the Azure App Service"
  type        = string
  default     = "app-portfolio-webapp-dev-001"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "Development"
}

variable "project_name" {
  description = "Project name used for tagging"
  type        = string
  default     = "Azure-Cloud-Portfolio"
}