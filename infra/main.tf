locals {
  name_prefix =        "${var.project_name}-${var.environment}"
}

module "rg" {
  source              = "./modules/resource_group"
  name_prefix         = local.name_prefix
  location            = var.location
}

module "identity" {
  source              = "./modules/identity"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = module.rg.name
}

module "storage" {
  source              = "./modules/storage"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = module.rg.name
}

module "functionapp" {
  source              = "./modules/functionapp"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = module.rg.name
  storage_name        = module.storage.name
  identity_id         = module.identity.id
  storage_access_key  = module.storage.access_key
}

resource "azurerm_role_assignment" "identity_storage" {
  scope                = module.storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.identity.principal_id
  depends_on            = [module.storage]
}