variable "project_name" {
  type        = string
  description = "Base name for resources"
}

variable "location" {
  type        = string
  default     = "eastus"
}

variable "environment" {
  type        = string
  default     = "prod"
}
