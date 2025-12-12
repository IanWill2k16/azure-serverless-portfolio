variable "name_prefix" {
  type        = string
  description = "Prefix used for naming resources"
}

variable "location" {
  type        = string
  description = "Azure region for the identity"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group in which the identity will be created"
}
