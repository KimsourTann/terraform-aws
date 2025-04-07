terraform {
  backend "remote" {
    organization = "Kimsour-DevOps"

    workspaces {
      name = "terraform-backend"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_key
  secret_key = var.aws_secret
}