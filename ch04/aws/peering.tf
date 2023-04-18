resource "aws_vpc_peering_connection" "peering_connection" {
  peer_vpc_id = aws_vpc.vpc_02.id
  vpc_id      = aws_vpc.vpc_01.id
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

locals {
  pc = aws_vpc_peering_connection.peering_connection
  pc_id = local.pc.id
}

resource "aws_route" "route_a_to_b" {
  route_table_id = aws_route_table.new_rt_01.id
  destination_cidr_block = aws_vpc.vpc_02.cidr_block

  vpc_peering_connection_id = local.pc_id
}

resource "aws_route" "route_b_to_a" {
  route_table_id = aws_route_table.new_rt_02.id
  destination_cidr_block = aws_vpc.vpc_01.cidr_block

  vpc_peering_connection_id = local.pc_id
}

locals {
  sg_01 = aws_security_group.sg_01.id
  sg_02 = aws_security_group.sg_02.id
}

resource "aws_security_group_rule" "allow_all_from_sg_02" {
  type                     = "ingress"
  description              = "Allow all from SG 02"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = local.sg_02
  security_group_id        = local.sg_01
}

resource "aws_security_group_rule" "allow_all_from_sg_01" {
  type                     = "ingress"
  description              = "Allow all from SG 01"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = local.sg_01
  security_group_id        = local.sg_02 
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

resource "aws_security_group_rule" "allow_ec2_instance_connect_to_vm_01" {
  type              = "ingress"
  description       = "Allow EC2 instance connect"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = local.ic_cidr_blocks
  ipv6_cidr_blocks  = local.ic_ipv6_cidr_blocks
  security_group_id = local.sg_01
}

resource "aws_security_group_rule" "allow_ec2_instance_connect_to_vm_02" {
  type              = "ingress"
  description       = "Allow EC2 instance connect"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = local.ic_cidr_blocks
  ipv6_cidr_blocks  = local.ic_ipv6_cidr_blocks
  security_group_id = local.sg_02
}
