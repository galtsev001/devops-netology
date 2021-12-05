terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "netology-s3"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }
}