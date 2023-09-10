resource "aws_vpc" "vpc_target" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Target VPC"
  }
}

resource "aws_subnet" "public_subnet_target" {
  vpc_id     = aws_vpc.vpc_target.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public Subnet of Target VPC"
  }
}

resource "aws_internet_gateway" "ig_target" {
  vpc_id = aws_vpc.vpc_target.id

  tags = {
    Name = "Internet Gateway of Target VPC"
  }
}

resource "aws_route_table" "new_rt_target" {
  vpc_id = aws_vpc.vpc_target.id

  tags = {
    Name = "New Route Table for Target VPC"
  }
}

resource "aws_route" "new_rt_target_route" {
  route_table_id            = aws_route_table.new_rt_target.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.ig_target.id
}

resource "aws_route_table_association" "subnet_assoc_for_vpc_target" {
  subnet_id      = aws_subnet.public_subnet_target.id
  route_table_id = aws_route_table.new_rt_target.id
}

resource "aws_security_group" "sg_target" {
  name        = "target-sg-vpc_target"
  description = "SG of Instance in Target VPC"
  vpc_id      = aws_vpc.vpc_target.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_target_02" {
  name        = "target-sg-02-vpc_target"
  description = "SG of Instance 02 in Target VPC"
  vpc_id      = aws_vpc.vpc_target.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_all_from_sg_target_to_target_02" {
  type                     = "ingress"
  description              = "Allow all from SG of Target Instance to Target Instance 02"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.sg_target.id
  security_group_id        = aws_security_group.sg_target_02.id
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

resource "aws_instance" "vm_target" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "target-vm-01"
  }

  associate_public_ip_address = true
  subnet_id = aws_subnet.public_subnet_target.id
  vpc_security_group_ids = [
    aws_security_group.sg_target.id
  ]


  user_data = <<-EOF
    #!/bin/bash
    sleep 15
    echo "STEP: CREATE FLAG FILE"
    echo "FLAG # 1!" > /root/flag.txt
    
    sleep 15
    echo "STEP: SET UP SSH ACCESS"
    NEW_USER=adminuser 
    adduser --disabled-password --gecos "" $NEW_USER 
    echo "$NEW_USER ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers >/dev/null
    mkdir -p /home/$NEW_USER/.ssh 
    chown $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh 
    chmod 700 /home/$NEW_USER/.ssh 
    echo "$NEW_USER:password" | chpasswd 
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    systemctl restart ssh
  EOF

}

resource "aws_instance" "vm_target_02" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "target-vm-02"
  }

  associate_public_ip_address = true
  subnet_id = aws_subnet.public_subnet_target.id
  vpc_security_group_ids = [
    aws_security_group.sg_target_02.id
  ]


  user_data = <<-EOF
    #!/bin/bash
    sleep 15
    echo "STEP: CREATE FLAG FILE"
    echo "FLAG # 2!" > /root/flag.txt
    
    sleep 15
    echo "STEP: SET UP SSH ACCESS"
    NEW_USER=adminuser2 
    adduser --disabled-password --gecos "" $NEW_USER 
    echo "$NEW_USER ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers >/dev/null
    mkdir -p /home/$NEW_USER/.ssh 
    chown $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh 
    chmod 700 /home/$NEW_USER/.ssh 
    echo "$NEW_USER:password" | chpasswd 
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    systemctl restart ssh
  EOF

}

output "vm_target_private_ip" {
  value = aws_instance.vm_target.private_ip
}

output "vm_target_public_ip" {
  value = aws_instance.vm_target.public_ip
}

output "vm_target_02_private_ip" {
  value = aws_instance.vm_target_02.private_ip
}

output "vm_target_02_public_ip" {
  value = aws_instance.vm_target_02.public_ip
}
