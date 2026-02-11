resource "azurerm_resource_group" "this" {
  name     = var.name
  location = "northeurope"
}
