provider "aws" {
  region = var.region
  access_key = var.aws_key
  secret_key = var.aws_secret
}


module "key_pair" {
  source = "../../../modules/key-pair"
}


module "ec2" {
  source = "../../../modules/ec2-v2"
  key_pair_id = module.key_pair.key_pair_name
  security_group_ids = [data.terraform_remote_state.sg.outputs.security_group_id]
  subnet_id = data.terraform_remote_state.subnet.outputs.subnet_id[0]
}

# version use default VPC
# module "ec2" {
#   source = "../../../modules/ec2"
#   key_pair_id = module.key_pair.key_pair_name
# }