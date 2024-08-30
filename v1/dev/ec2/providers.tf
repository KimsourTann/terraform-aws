provider "aws" {
  region = var.region
  access_key = var.aws_key
  secret_key = var.aws_secret
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.56"
    }
  }
   backend "s3" {
    bucket = "kimsour-terraform-state"
    key = "ec2-test/s3/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "terraform-state"
    encrypt = true
  }
}
