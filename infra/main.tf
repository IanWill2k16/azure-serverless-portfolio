locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

module "rg" {
  source      = "./modules/resource_group"
  name_prefix = local.name_prefix
  location    = var.location
}

module "identity" {
  source      = "./modules/identity"
  name_prefix = local.name_prefix
  location    = var.location
  resource_group_name = module.rg.name
}

module "storage" {
  source      = "./modules/storage"
  name_prefix = local.name_prefix
  location    = var.location
  resource_group_name = module.rg.name
}

module "functionapp" {
  source              = "./modules/functionapp"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = module.rg.name
  storage_name        = module.storage.name
  identity_id         = module.identity.principal_id
  storage_access_key  = module.storage.access_key
  app_service_plan_id = module.plan.id
}

module "plan" {
  source = "./modules/app_service_plan"

  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = module.rg.name
}
