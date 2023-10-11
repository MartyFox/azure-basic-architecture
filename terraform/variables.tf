variable "location" {
  type    = string
  default = "uk south"
}

variable "tags" {
  type    = map(any)
  default = {}
}

# variable "admin_password" {
#   description = "administrator password"
#   type        = string
#   sensitive   = true
# }