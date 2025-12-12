output "name" {
  value = azurerm_storage_account.sa.name
}

output "static_site_url" {
  value = azurerm_storage_account.sa.primary_web_endpoint
}
