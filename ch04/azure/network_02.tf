resource "azurerm_resource_group" "rg_02" {
  location = "eastus"
  name     = "resource-group-02"
}

resource "azurerm_virtual_network" "vnet_02" {
  name                = "vnet-02"
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.rg_02.location
  resource_group_name = azurerm_resource_group.rg_02.name
}

resource "azurerm_subnet" "subnet_02" {
  name                 = "subnet-02"
  resource_group_name  = azurerm_resource_group.rg_02.name
  virtual_network_name = azurerm_virtual_network.vnet_02.name
  address_prefixes     = ["192.168.1.0/24"]
}

resource "azurerm_public_ip" "public_ip_02" {
  name                = "public-ip-02"
  location            = azurerm_resource_group.rg_02.location
  resource_group_name = azurerm_resource_group.rg_02.name
  allocation_method   = "Dynamic"
}

resource "azurerm_application_security_group" "asg_02" {
  name                = "asg-02"
  location            = azurerm_resource_group.rg_02.location
  resource_group_name = azurerm_resource_group.rg_02.name
}

resource "azurerm_network_security_group" "nsg_02" {
  name                = "nsg-02"
  location            = azurerm_resource_group.rg_02.location
  resource_group_name = azurerm_resource_group.rg_02.name
}

resource "azurerm_network_interface" "nic_02" {
  name                = "nic-02"
  location            = azurerm_resource_group.rg_02.location
  resource_group_name = azurerm_resource_group.rg_02.name

  ip_configuration {
    name                          = "nic_configuration_02"
    subnet_id                     = azurerm_subnet.subnet_02.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_02.id
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc_2" {
  network_interface_id      = azurerm_network_interface.nic_02.id
  network_security_group_id = azurerm_network_security_group.nsg_02.id
}

resource "azurerm_network_interface_application_security_group_association" "asg_assoc_2" {
  network_interface_id          = azurerm_network_interface.nic_02.id
  application_security_group_id = azurerm_application_security_group.asg_02.id
}

resource "azurerm_linux_virtual_machine" "vm_02" {
  name                  = "vm-02"
  location              = azurerm_resource_group.rg_02.location
  resource_group_name   = azurerm_resource_group.rg_02.name
  size                  = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.nic_02.id]

  os_disk {
    name                 = "os-disk-02"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "vm-02"
  admin_username                  = local.vm_username
  admin_password                  = local.vm_password
  disable_password_authentication = false

  boot_diagnostics {
    storage_account_uri = null
  }
}

output "vm_02_private_ip" {
  value = azurerm_linux_virtual_machine.vm_02.private_ip_address
}

output "vm_02_public_ip" {
  value = azurerm_linux_virtual_machine.vm_02.public_ip_address
}
