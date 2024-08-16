resource "aws_instance" "web" {
  ami                     = "ami-00db8dadb36c9815e"
  instance_type           = "t2.micro"
  key_name = var.key_pair_id
  vpc_security_group_ids = var.security_group_ids
  subnet_id = var.subnet_id
  user_data = var.user_data
  tags = {
    Name = "${var.env}-web"
  }
}
