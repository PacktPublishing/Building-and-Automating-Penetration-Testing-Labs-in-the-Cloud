resource "random_string" "random_password" {
  length           = 12
  special          = true
  override_special = "!#$%&"
  min_lower        = 2
  min_special      = 2
  min_upper        = 2
}

locals {
    vm_username = "testuser"
    vm_password = random_string.random_password.result
}

output "vm_username" {
  value = local.vm_username
}

output "vm_password" {
  value = local.vm_password
}
