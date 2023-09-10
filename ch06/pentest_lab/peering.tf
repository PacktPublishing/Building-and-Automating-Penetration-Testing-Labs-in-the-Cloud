resource "aws_vpc_peering_connection" "peering_connection" {
  peer_vpc_id = aws_vpc.vpc_attacker.id
  vpc_id      = aws_vpc.vpc_target.id
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }

}

locals {
  pc = aws_vpc_peering_connection.peering_connection
  pc_id = local.pc.id
}

resource "aws_route" "route_a_to_b" {
  route_table_id = aws_route_table.new_rt_target.id
  destination_cidr_block = aws_vpc.vpc_attacker.cidr_block

  vpc_peering_connection_id = local.pc_id



  depends_on = [
    aws_route_table_association.subnet_assoc_for_vpc_target,
    aws_route_table_association.subnect_assoc_for_vpc_attacker,
    aws_vpc_peering_connection.peering_connection    
  ]


}

resource "aws_route" "route_b_to_a" {
  route_table_id = aws_route_table.new_rt_attacker.id
  destination_cidr_block = aws_vpc.vpc_target.cidr_block

  vpc_peering_connection_id = local.pc_id


  depends_on = [
    aws_route_table_association.subnet_assoc_for_vpc_target,
    aws_route_table_association.subnect_assoc_for_vpc_attacker,
    aws_vpc_peering_connection.peering_connection    
  ]

}

locals {
  sg_target = aws_security_group.sg_target.id
  sg_attacker = aws_security_group.sg_attacker.id
}

resource "aws_security_group_rule" "allow_all_from_sg_attacker" {
  type                     = "ingress"
  description              = "Allow all from SG of Kali Instance"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = local.sg_attacker
  security_group_id        = local.sg_target
}

resource "aws_security_group_rule" "allow_all_from_sg_target" {
  type                     = "ingress"
  description              = "Allow all from SG of Target Instance"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = local.sg_target
  security_group_id        = local.sg_attacker 
}

data "aws_ip_ranges" "ec2_instance_connect" {
  regions  = ["us-east-1"]
  services = ["EC2_INSTANCE_CONNECT"]
}

locals {
  ic = data.aws_ip_ranges.ec2_instance_connect
  ic_cidr_blocks = local.ic.cidr_blocks
  ic_ipv6_cidr_blocks = local.ic.ipv6_cidr_blocks
}

resource "aws_security_group_rule" "allow_ec2_instance_connect_to_vm_target" {
  type              = "ingress"
  description       = "Allow EC2 instance connect"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = local.ic_cidr_blocks
  ipv6_cidr_blocks  = local.ic_ipv6_cidr_blocks
  security_group_id = local.sg_target
}