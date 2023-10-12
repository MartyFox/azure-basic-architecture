resource "azurerm_resource_group" "rsi" {
  name     = "rsi-${var.environment}-rg"
  location = var.location
}