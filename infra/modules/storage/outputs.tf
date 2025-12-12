output "name" {
  value = azurerm_storage_account.sa.name
}

output "static_site_url" {
  value = azurerm_storage_account.sa.primary_web_endpoint
}

output "access_key" {
  value = azurerm_storage_account.sa.primary_access_key
}

output "id" {
  value = azurerm_storage_account.sa.id
}