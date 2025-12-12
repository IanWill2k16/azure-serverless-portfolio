resource "azurerm_linux_function_app" "func" {
  name                = "${var.name_prefix}-fn"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  storage_account_name       = var.storage_name
  storage_account_access_key = var.storage_access_key

  identity {
    type = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  site_config {
    application_stack {
      python_version = "3.10"
    }
  }
}

output "url" {
  value = azurerm_linux_function_app.func.default_hostname
}
