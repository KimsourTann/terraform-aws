provider "aws" {
  region = var.region
  access_key = var.aws_key
  secret_key = var.aws_secret
}

module "subnet" {
  source = "../../../modules/subnet"
  env = var.env
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  cidr_block = var.cidr_block
}