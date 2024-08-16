provider "aws" {
  region = var.region
  access_key = var.aws_key
  secret_key = var.aws_secret
}

# terraform {
#   required_version = ">= 1.3"
#   required_providers {
#     aws = {
#         source = "hashicorp/aws"
#         version = "~> 5.56"
#     }
#   }
# }

module "subnet" {
  source = "../../../modules/subnet"
  for_each = toset(var.subnet_cdir_blocks)
  env = var.env
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  cidr_block = each.value
}