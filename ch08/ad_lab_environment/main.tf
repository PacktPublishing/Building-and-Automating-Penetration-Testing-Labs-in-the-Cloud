module "secure_network" {
  source = "./secure_network"

  my_ip = var.my_ip
}

module "attacker_vm" {
  source = "./attacker_vm"

  my_public_ssh_key = var.my_public_ssh_key
  source_image_id = var.kali_image_id
  rg_location = module.secure_network.rg_02_location
  rg_name = module.secure_network.rg_02_name
  subnet = module.secure_network.subnet_02
  asg = module.secure_network.asg_02
  nsg = module.secure_network.nsg_02
}