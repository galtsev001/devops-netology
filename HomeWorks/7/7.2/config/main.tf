provider "aws" {
  profile = "default"
  region  = "eu-west-2"
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
  owners = ["099720109477"] # Canonical
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_instance" "netology" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
}