resource "azurerm_user_assigned_identity" "id" {
  name                = "${var.name_prefix}-uaid"
  location            = var.location
  resource_group_name = var.resource_group_name
}

output "principal_id" {
  value = azurerm_user_assigned_identity.id.principal_id
}
