provider "aws" {
  region = var.region
  access_key = var.aws_key
  secret_key = var.aws_secret
}

# Use to setup s3 as Backend
# terraform {
#   backend "s3" {
#     bucket = "kimsour-terraform-state"
#     key = "ec2-test/s3/terraform.tfstate"
#     region = "us-east-2"
#     dynamodb_table = "terraform-state"
#     encrypt = true
#   }
# }


data "aws_vpc" "default" {
  default = true
} 

# resource "aws_default_vpc" "default" {
#   tags = {
#     Name = "Default VPC"
#   }
# }

resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-east-2a"

  tags = {
    Name = "Default subnet for us-west-2a"
  }
}

module "key_pair" {
  source = "../../../modules/key-pair"
}

module "sg" {
  source = "../../../modules/sg"
  env = var.env
  vpc_id = data.aws_vpc.default.id
  ingressess = var.ingressess
  egressess = var.egressess
}

module "ec2" {
  count = 2
  source = "../../../modules/ec2-v2"
  key_pair_id = module.key_pair.key_pair_name
  security_group_ids = [module.sg.security_group_id]
  subnet_id = aws_default_subnet.default_az1.id
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              sudo mkdir -p /var/www/html && sudo touch /var/www/html/index.html
              sudo echo "Hello World from $(hostname -f)" > /var/www/html/index.html
              EOF
}

# version use default VPC
# module "ec2" {
#   source = "../../../modules/ec2"
#   key_pair_id = module.key_pair.key_pair_name
# }