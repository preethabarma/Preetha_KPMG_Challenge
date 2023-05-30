resource "azurerm_resource_group" "rg" {
  name     = "DemoRg"
  location = var.location_rg
  tags = {
    "Application" = "DemoApp"
  }
}