resource "azurerm_resource_group" "tfstate" {
  name     = "${var.project_name}-${var.environment}-tfstate-rg"
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "${var.project_name}${var.environment}tf"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id  = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

output "tfstate_storage_account_name" {
  value = azurerm_storage_account.tfstate.id
}

output "tfstate_container_name" {
  value = azurerm_storage_container.tfstate.id
}

output "tfstate_rg_name" {
  value = azurerm_resource_group.tfstate.name
}

terraform {
  backend "azurerm" {
    resource_group_name  = "cloudportfolio-prod-tfstate-rg"
    storage_account_name = "cloudportfolioprodtf"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
