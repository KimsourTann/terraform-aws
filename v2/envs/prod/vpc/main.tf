provider "aws" {
  region = var.region
  access_key = var.aws_key
  secret_key = var.aws_secret
}

module "vpc" {
  source = "../../../modules/vpc"
  env = var.env
  cidr_block = var.cidr_block
}