resource "azurerm_resource_group" "rsi" {
  name     = "rsi-rg"
  location = var.location
}