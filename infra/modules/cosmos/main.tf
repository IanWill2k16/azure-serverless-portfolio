resource "azurerm_cosmosdb_account" "this" {
  name                = "${var.name_prefix}-cosmos"
  location            = var.location
  resource_group_name = var.resource_group_name

  offer_type = "Standard"
  kind       = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  capabilities {
    name = "EnableServerless"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableTable"
  }
}

resource "azurerm_cosmosdb_table" "visits" {
  name                = "Visits"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
}

data "azurerm_cosmosdb_role_definition" "table_data_contributor" {
  account_name        = azurerm_cosmosdb_account.this.name
  resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
  name                = "Cosmos DB Built-in Data Contributor"
}

resource "azurerm_cosmosdb_role_assignment" "func_table_access" {
  account_name        = azurerm_cosmosdb_account.this.name
  resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
  role_definition_id  = data.azurerm_cosmosdb_role_definition.table_data_contributor.id
  principal_id        = var.function_principal_id
  scope               = "/"
}

