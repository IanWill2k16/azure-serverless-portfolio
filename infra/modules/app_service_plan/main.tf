resource "azurerm_service_plan" "this" {
  name                = "${var.name_prefix}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id

  os_type  = "Linux"
  sku_name = "Y1"
}
