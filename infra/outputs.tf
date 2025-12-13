output "static_site_url" {
  value = module.storage.static_site_url
}

output "function_app_url" {
  value = module.functionapp.url
}

output "storage_account_name" {
  value = module.storage.name
}