terraform {
  backend "azurerm" {
    storage_account_name = "sttfstateoscar15994"
    container_name       = "tfstate"
    key                  = "azure-secure-webapp-platform.tfstate"

    use_cli          = true
    use_azuread_auth = true
  }
}