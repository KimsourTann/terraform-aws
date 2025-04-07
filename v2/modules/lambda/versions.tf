terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.56"
    }
  }
}
provider "aws" {
  region = "us-east-2"
  access_key = var.aws_key
  secret_key = var.aws_secret
}