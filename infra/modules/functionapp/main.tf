resource "azurerm_service_plan" "this" {
  name                = "${var.name}-fc-plan"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_name = "FC1"
  os_type  = "Linux"
}

resource "azurerm_function_app_flex_consumption" "func" {
  name                = "${var.name_prefix}-fn"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  storage_container_type      = "blobContainer"
  storage_container_endpoint  = "${var.storage_blob_endpoint}${var.storage_container}"
  storage_authentication_type = "StorageAccountConnectionString"
  storage_access_key          = var.storage_access_key

  runtime_name        = "python"
  runtime_version     = "3.10"

  site_config {}
}

output "url" {
  value = azurerm_linux_function_app.func.default_hostname
}
