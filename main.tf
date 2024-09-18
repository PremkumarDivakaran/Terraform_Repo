provider "aws" {
  region = "ap-south-1"
}

# Data block to fetch the existing VPC by ID
data "aws_vpc" "existing_vpc" {
  id = "vpc-06fadc01ce9aaca84"
}

# Data block to fetch the existing Subnet by ID
data "aws_subnet" "existing_subnet" {
  id = "subnet-0adfc09376bbf3112"
}

# Create a security group allowing inbound SSH and HTTP
resource "aws_security_group" "my_sg" {
  vpc_id = data.aws_vpc.existing_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "my_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = tls_private_key.my_private_key.public_key_openssh
}

output "private_key_pem" {
  value     = tls_private_key.my_private_key.private_key_pem
  sensitive = true
}

# Create an EC2 instance
resource "aws_instance" "my_instance" {
  ami           = "ami-0522ab6e1ddcc7055"
  instance_type = "t2.micro"
  key_name          = aws_key_pair.my_key.key_name
  subnet_id         = data.aws_subnet.existing_subnet.id
  vpc_security_group_ids   = [aws_security_group.my_sg.id]

  tags = {
    Name = "MyInstance"
  }
}

# Output the public IP of the instance
output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}
