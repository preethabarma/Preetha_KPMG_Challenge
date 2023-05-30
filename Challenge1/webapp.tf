#Frontend
# Create the web app, pass in the App Service Plan ID
resource "azurerm_windows_web_app" "fe-webapp" {
  name                = "frontendapp1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.fe-asp.id
  https_only          = true
  site_config {
    always_on = true

    application_stack {
      java_version = "11"
    }
  }

  app_settings = {

    "APPINSIGHTS_INSTRUMENTATIONKEY"             = azurerm_application_insights.demo-appinsights.instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION"        = "1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
  }

  depends_on = [
    azurerm_service_plan.fe-asp, azurerm_application_insights.demo-appinsights
  ]
}


#Backend
# Create the web app, pass in the App Service Plan ID
resource "azurerm_windows_web_app" "be-webapp" {
  name                = "backenddemoapp1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.be-asp.id
  https_only          = true
  site_config {
    always_on = true

    application_stack {
      java_version = "11"
    }

    ip_restriction {
      virtual_network_subnet_id = azurerm_subnet.fe-subnet.id
      priority                  = 100
      name                      = "Frontend access only"
    }
  }

  app_settings = {

    "APPINSIGHTS_INSTRUMENTATIONKEY"             = azurerm_application_insights.demo-appinsights.instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION"        = "1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
  }

  depends_on = [
    azurerm_service_plan.be-asp, azurerm_application_insights.demo-appinsights
  ]
}

#vnet integration of frontend app
resource "azurerm_app_service_virtual_network_swift_connection" "fe-vnet-integration" {
  app_service_id = azurerm_windows_web_app.fe-webapp.id
  subnet_id      = azurerm_subnet.fe-subnet.id
  depends_on = [
    azurerm_windows_web_app.fe-webapp
  ]
}

#vnet integration of backend app
resource "azurerm_app_service_virtual_network_swift_connection" "be-vnet-integration" {
  app_service_id = azurerm_windows_web_app.be-webapp.id
  subnet_id      = azurerm_subnet.be-subnet.id
  depends_on = [
    azurerm_windows_web_app.be-webapp
  ]
}
