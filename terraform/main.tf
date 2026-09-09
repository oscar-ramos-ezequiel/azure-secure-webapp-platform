data "azurerm_resource_group" "portfolio" {
  name = var.resource_group_name
}

data "azurerm_linux_web_app" "portfolio" {
  name                = var.app_service_name
  resource_group_name = data.azurerm_resource_group.portfolio.name
}