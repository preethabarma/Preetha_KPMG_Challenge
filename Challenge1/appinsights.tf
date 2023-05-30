resource "azurerm_log_analytics_workspace" "demo-loganalytics" {
  name                = "demo-la-workspace"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "demo-appinsights" {
  name                = "demo-appinsights"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  workspace_id        = azurerm_log_analytics_workspace.demo-loganalytics.id
  application_type    = "web"
  depends_on = [
    azurerm_log_analytics_workspace.demo-loganalytics
  ]
}
