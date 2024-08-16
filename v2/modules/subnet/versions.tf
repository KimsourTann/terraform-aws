# provider "aws" {
#   region = var.region
#   access_key = var.aws_key
#   secret_key = var.aws_secret
# }

# terraform {
#   required_version = ">= 1.2"
#   required_providers {
#     aws = {
#         source = "hashicorp/aws"
#         version = "~> 5.56"
#     }
#   }
# }