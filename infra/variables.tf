variable "project_name" {
  type        = string
  description = "Base name for resources"
  default     = "cloudportfolio"
}

variable "location" {
  type        = string
  default     = "eastus"
}

variable "environment" {
  type        = string
  default     = "prod"
}

variable "oidc_client_id" {
  type        = string
}
variable "tenant_id" {
  type        = string
}
variable "subscription_id" {
  type        = string
}
