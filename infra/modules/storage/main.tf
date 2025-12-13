resource "azurerm_storage_account" "sa" {
  name                     = replace("${var.name_prefix}sa", "-", "")
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "code" {
  name                  = "code"
  storage_account_id  = azurerm_storage_account.sa.id
  container_access_type = "private"
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "github_blob" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "time_sleep" "rbac_propagation" {
  triggers = {
    role_assignment_id = azurerm_role_assignment.github_blob.id
  }

  create_duration = "30s"
}

resource "azurerm_storage_account_static_website" "website" {
  storage_account_id = azurerm_storage_account.sa.id

  index_document = "index.html"
  error_404_document = "404.html"
}
