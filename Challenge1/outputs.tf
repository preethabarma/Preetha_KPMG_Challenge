
output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "instrumentation_key" {
  value     = azurerm_application_insights.demo-appinsights.instrumentation_key
  sensitive = true
}

output "app_id" {
  value     = azurerm_application_insights.demo-appinsights.id
  sensitive = true
}

output "frontend_url" {
  value = "${azurerm_windows_web_app.fe-webapp.name}.azurewebsites.net"
}

output "backend_url" {
  value = "${azurerm_windows_web_app.be-webapp.name}.azurewebsites.net"
}