resource "azurerm_cdn_profile" "this" {
  name                = "${var.name_prefix}-cdn"
  location            = "global"
  resource_group_name = var.resource_group_name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "this" {
  name                = "${var.name_prefix}-cdn-endpoint"
  profile_name        = azurerm_cdn_profile.this.name
  location            = "global"
  resource_group_name = var.resource_group_name

  origin {
    name      = "storageorigin"
    host_name = var.storage_primary_web_host
  }

  is_http_allowed  = false
  is_https_allowed = true
}
