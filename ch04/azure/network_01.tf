resource "azurerm_resource_group" "rg_01" {
  location = "eastus"
  name     = "resource-group-01"
}

resource "azurerm_virtual_network" "vnet_01" {
  name                = "vnet-01"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_01.location
  resource_group_name = azurerm_resource_group.rg_01.name
}

resource "azurerm_subnet" "subnet_01" {
  name                 = "subnet-01"
  resource_group_name  = azurerm_resource_group.rg_01.name
  virtual_network_name = azurerm_virtual_network.vnet_01.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "public_ip_01" {
  name                = "public-ip-01"
  location            = azurerm_resource_group.rg_01.location
  resource_group_name = azurerm_resource_group.rg_01.name
  allocation_method   = "Dynamic"
}

resource "azurerm_application_security_group" "asg_01" {
  name                = "asg-01"
  location            = azurerm_resource_group.rg_01.location
  resource_group_name = azurerm_resource_group.rg_01.name
}

resource "azurerm_network_security_group" "nsg_01" {
  name                = "nsg-01"
  location            = azurerm_resource_group.rg_01.location
  resource_group_name = azurerm_resource_group.rg_01.name
}

resource "azurerm_network_interface" "nic_01" {
  name                = "nic-01"
  location            = azurerm_resource_group.rg_01.location
  resource_group_name = azurerm_resource_group.rg_01.name

  ip_configuration {
    name                          = "nic_configuration_01"
    subnet_id                     = azurerm_subnet.subnet_01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_01.id
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc_1" {
  network_interface_id      = azurerm_network_interface.nic_01.id
  network_security_group_id = azurerm_network_security_group.nsg_01.id
}

resource "azurerm_network_interface_application_security_group_association" "asg_assoc_1" {
  network_interface_id          = azurerm_network_interface.nic_01.id
  application_security_group_id = azurerm_application_security_group.asg_01.id
}

resource "azurerm_linux_virtual_machine" "vm_01" {
  name                  = "vm-01"
  location              = azurerm_resource_group.rg_01.location
  resource_group_name   = azurerm_resource_group.rg_01.name
  size                  = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.nic_01.id]

  os_disk {
    name                 = "os-disk-01"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "vm-01"
  admin_username                  = local.vm_username
  admin_password                  = local.vm_password
  disable_password_authentication = false

  boot_diagnostics {
    storage_account_uri = null
  }
}

output "vm_01_private_ip" {
  value = azurerm_linux_virtual_machine.vm_01.private_ip_address
}

output "vm_01_public_ip" {
  value = azurerm_linux_virtual_machine.vm_01.public_ip_address
}
