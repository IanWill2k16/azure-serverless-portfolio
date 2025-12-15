output "account_name" {
  value = azurerm_cosmosdb_account.this.name
}

output "table_name" {
  value = azurerm_cosmosdb_table.visits.name
}

output "primary_key" {
  value = azurerm_cosmosdb_account.this.primary_key
  sensitive = true
}

output "table_endpoint" {
  value = azurerm_cosmosdb_account.this.primary_table_endpoint
}