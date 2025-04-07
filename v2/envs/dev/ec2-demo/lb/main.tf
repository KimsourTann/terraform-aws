provider "aws" {
  region = var.region
  access_key = var.aws_key
  secret_key = var.aws_secret
}


module "lb" {
  source  = "../../../../modules/lb"
  type = var.type
  name = var.name
  subnets = tolist(data.terraform_remote_state.subnet.outputs.subnet_id)
  security_groups = [data.terraform_remote_state.sg.outputs.security_group_id]
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  depends_on = [  ]
}