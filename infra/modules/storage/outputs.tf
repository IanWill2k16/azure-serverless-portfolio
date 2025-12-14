output "name" {
  value = azurerm_storage_account.sa.name
}

output "static_site_url" {
  value = trimsuffix(azurerm_storage_account.sa.primary_web_endpoint, "/")
}

output "access_key" {
  value = azurerm_storage_account.sa.primary_access_key
}

output "id" {
  value = azurerm_storage_account.sa.id
}

output "blob_endpoint" {
  value = azurerm_storage_account.sa.primary_blob_endpoint
}

output "code_container_name" {
  value = azurerm_storage_container.code.name
}
