output "asg_01" {
  value = azurerm_application_security_group.asg_01.id
}

output "nsg_01" {
  value = azurerm_network_security_group.nsg_01.id
}

output "rg_01_location" {
  value = azurerm_resource_group.rg_01.location
}

output "rg_01_name" {
  value = azurerm_resource_group.rg_01.name
}

output "subnet_01" {
  value = azurerm_subnet.subnet_01.id
}

output "asg_02" {
  value = azurerm_application_security_group.asg_02.id
}

output "nsg_02" {
  value = azurerm_network_security_group.nsg_02.id
}

output "rg_02_location" {
  value = azurerm_resource_group.rg_02.location
}

output "rg_02_name" {
  value = azurerm_resource_group.rg_02.name
}

output "subnet_02" {
  value = azurerm_subnet.subnet_02.id
}
