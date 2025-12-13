terraform {
  backend "azurerm" {
    resource_group_name  = "cloudportfolio-prod-tfstate-rg"
    storage_account_name = "cloudportfolioprodtf"
    container_name       = "tfstate"
    key                  = "terraform-${var.environmet}.tfstate"
  }
}
