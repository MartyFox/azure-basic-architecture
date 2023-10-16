resource "azurerm_log_analytics_workspace" "rsi-law" {
  name                = "rsi-${var.environment}-law"
  resource_group_name = azurerm_resource_group.rsi.name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}