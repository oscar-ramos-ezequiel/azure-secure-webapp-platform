resource "azurerm_resource_group" "portfolio" {
  name     = var.resource_group_name
  location = "West Europe"

  tags = {
    Environment = "Development"
    Project     = "Azure-Cloud-Portfolio"
    ManagedBy   = "Terraform"
    Purpose     = "Learning"
  }
}

resource "azurerm_service_plan" "portfolio" {
  name                = "ASP-rgportfoliowebappdev001-afe5"
  resource_group_name = azurerm_resource_group.portfolio.name
  location            = "France Central"
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "portfolio" {
  name                = var.app_service_name
  resource_group_name = azurerm_resource_group.portfolio.name
  location            = azurerm_service_plan.portfolio.location
  service_plan_id     = azurerm_service_plan.portfolio.id

  https_only = true

  site_config {
    application_stack {
      python_version = "3.14"
    }
  }
}