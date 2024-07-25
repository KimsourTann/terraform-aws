resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  enable_dns_hostnames = false
  enable_dns_support = false

  tags = {
    Name = "${var.env}-main"
  }
}