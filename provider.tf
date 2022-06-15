terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }
}

provider "aws" {
  region     = "eu-west-1" //Virginia
  access_key = var.ACCESS-KEY
  secret_key = var.SECRET-KEY
}
