output "url" {
  value = azurerm_function_app_flex_consumption.func.default_hostname
}

output "principal_id" {
  value = azurerm_function_app_flex_consumption.func.identity[0].principal_id
}