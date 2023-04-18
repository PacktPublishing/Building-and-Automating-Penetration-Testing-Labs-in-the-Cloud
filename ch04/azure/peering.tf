resource "azurerm_virtual_network_peering" "peer_1_to_2" {
  name                      = "peer1to2"
  resource_group_name       = azurerm_resource_group.rg_01.name
  virtual_network_name      = azurerm_virtual_network.vnet_01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_02.id
}

resource "azurerm_virtual_network_peering" "peer_2_to_1" {
  name                      = "peer2to1"
  resource_group_name       = azurerm_resource_group.rg_02.name
  virtual_network_name      = azurerm_virtual_network.vnet_02.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_01.id
}
