resource "aws_vpc" "vpc_02" {
  cidr_block           = "20.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC 02"
  }
}


resource "aws_subnet" "public_subnet_02" {
  vpc_id     = aws_vpc.vpc_02.id
  cidr_block = "20.0.1.0/24"

  tags = {
    Name = "Public Subnet of VPC 02"
  }
}


resource "aws_internet_gateway" "ig_02" {
  vpc_id = aws_vpc.vpc_02.id

  tags = {
    Name = "Internet Gateway of VPC 02"
  }
}

resource "aws_route_table" "new_rt_02" {
  vpc_id = aws_vpc.vpc_02.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_02.id
  }

  tags = {
    Name = "New Route Table for VPC 02"
  }
}

resource "aws_route_table_association" "subnect_assoc_for_vpc_02" {
  subnet_id      = aws_subnet.public_subnet_02.id
  route_table_id = aws_route_table.new_rt_02.id
}

resource "aws_security_group" "sg_02" {
  name        = "sample-sg-vpc_02"
  description = "SG of Test Instance in VPC 02"
  vpc_id      = aws_vpc.vpc_02.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vm_02" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "vm-02"
  }

  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet_02.id
  vpc_security_group_ids      = [aws_security_group.sg_02.id]
}
