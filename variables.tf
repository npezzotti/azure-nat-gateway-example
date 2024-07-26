variable "region" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "vm_password" {
  description = "VM password for password authentication"
  type        = string
  sensitive   = true
}
