provider "aws" {
  region = var.region
  access_key = var.aws_key
  secret_key = var.aws_secret
}

module "sg" {
  source = "../../../../modules/sg"
  env = var.env
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  ingressess = var.ingressess
  egressess = var.egressess
}