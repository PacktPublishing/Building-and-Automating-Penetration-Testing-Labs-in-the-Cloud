resource "aws_vpc" "vpc_01" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC 01"
  }
}

resource "aws_subnet" "public_subnet_01" {
  vpc_id     = aws_vpc.vpc_01.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public Subnet of VPC 01"
  }
}

resource "aws_internet_gateway" "ig_01" {
  vpc_id = aws_vpc.vpc_01.id

  tags = {
    Name = "Internet Gateway of VPC 01"
  }
}

resource "aws_route_table" "new_rt_01" {
  vpc_id = aws_vpc.vpc_01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_01.id
  }

  tags = {
    Name = "New Route Table for VPC 01"
  }
}

resource "aws_route_table_association" "subnet_assoc_for_vpc_01" {
  subnet_id      = aws_subnet.public_subnet_01.id
  route_table_id = aws_route_table.new_rt_01.id
}

resource "aws_security_group" "sg_01" {
  name        = "sample-sg-target"
  description = "SG of Test Instance in VPC 01"
  vpc_id      = aws_vpc.vpc_01.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "vm_01" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "vm-01"
  }

  associate_public_ip_address = true
  subnet_id = aws_subnet.public_subnet_01.id
  vpc_security_group_ids = [
    aws_security_group.sg_01.id
  ]
}

output "vm_01_private_ip" {
  value = aws_instance.vm_01.private_ip
}

output "vm_01_public_ip" {
  value = aws_instance.vm_01.public_ip
}
