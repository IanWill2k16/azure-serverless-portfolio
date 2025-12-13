resource "azurerm_service_plan" "this" {
  name                = "${var.name_prefix}-fc-plan"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_name = "FC1"
  os_type  = "Linux"
}

resource "azurerm_application_insights" "ai" {
  name                = "cloudportfolio-prod-ai"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}

resource "azurerm_function_app_flex_consumption" "func" {
  name                = "${var.name_prefix}-fn"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  storage_container_type      = "blobContainer"
  storage_container_endpoint  = "${var.storage_blob_endpoint}${var.code_container_name}"
  storage_authentication_type = "StorageAccountConnectionString"
  storage_access_key          = var.storage_access_key

  runtime_name        = "python"
  runtime_version     = "3.10"

  app_settings = {
    AzureWebJobsStorage = "DefaultEndpointsProtocol=https;AccountName=${var.storage_name};AccountKey=${var.storage_access_key};EndpointSuffix=core.windows.net"
    FUNCTIONS_EXTENSION_VERSION = "~4"
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.ai.connection_string
  }

  site_config {}
}

output "url" {
  value = azurerm_function_app_flex_consumption.func.default_hostname
}
