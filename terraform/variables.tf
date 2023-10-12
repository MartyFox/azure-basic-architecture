variable "location" {
  type    = string
  default = "uk south"
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "environment" {
  type = string
}

variable "admin_password" {
  description = "administrator password"
  default     = "C0mPl3xP@55"
  type        = string
  sensitive   = true
}