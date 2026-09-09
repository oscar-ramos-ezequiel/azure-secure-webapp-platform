output "resource_group_name" {
  description = "Azure Resource Group managed by Terraform"
  value       = azurerm_resource_group.portfolio.name
}

output "resource_group_location" {
  description = "Azure Resource Group location"
  value       = azurerm_resource_group.portfolio.location
}

output "app_service_name" {
  description = "Azure App Service name"
  value       = azurerm_linux_web_app.portfolio.name
}

output "app_service_default_hostname" {
  description = "Default hostname of the Azure App Service"
  value       = azurerm_linux_web_app.portfolio.default_hostname
}