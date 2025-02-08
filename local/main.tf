provider "aws" {
  region = "us-east-1"
}

# Defining local variables
locals {
  ami     = "ami-085ad6ae776d8f09c"
  type    = "t2.micro"
  subnet  = "subnet-04a3541ca3245dc75"
  
  tags = {
    name = "My Virtual Machine"
    env  = "Dev"
  }
}

# Creating a Network Interface (ENI)
resource "aws_network_interface" "my_network_interface" {
  description = "My network interface"
  subnet_id   = local.subnet

  tags = {
    name = "dev-interface"
  }
}

# Launching an EC2 Instance and calling local variables
resource "aws_instance" "myvm" {
  ami           = local.ami
  instance_type = local.type
  
  tags = local.tags

  network_interface {
    network_interface_id = aws_network_interface.my_network_interface.id
    device_index         = 0
  }
}

