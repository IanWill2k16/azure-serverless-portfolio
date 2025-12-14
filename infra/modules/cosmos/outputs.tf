output "account_name" {
  value = azurerm_cosmosdb_account.this.name
}

output "table_name" {
  value = azurerm_cosmosdb_table.visits.name
}
