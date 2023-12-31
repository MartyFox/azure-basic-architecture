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
  type      = string
  sensitive = true
}

variable "fe_instance_count" {
  type    = number
  default = 1
}

variable "fe_instance_type" {
  type = string
}