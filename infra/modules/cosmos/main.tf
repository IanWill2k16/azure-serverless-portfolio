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
