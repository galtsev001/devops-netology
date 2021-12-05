provider "aws" {
  region = "eu-north-1"
}

locals {
  type_instance = {
    stage = "t2.nano"
    prod = "t2.micro"
  }
  count_instance = {
    stage = 1
    prod = 2
  }
  instances = {
    "t2.nano" = data.aws_ami.ubuntu.id
    "t2.micro" = data.aws_ami.ubuntu.id
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "ec2_netology" {
  ami = data.aws_ami.ubuntu.id
  instance_type = local.type_instance[terraform.workspace]
  count = local.count_instance[terraform.workspace]
  associate_public_ip_address = false
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    name = "ec2_netology"
  }
}

resource "aws_instance" "ec2_netology_2" {
  for_each = local.instances
  ami = each.value
  instance_type = each.key
  associate_public_ip_address = false
  tags = {
    name = "ec2_netology_2"
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
