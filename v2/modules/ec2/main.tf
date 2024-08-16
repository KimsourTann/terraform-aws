resource "aws_instance" "web" {
  ami                     = "ami-00db8dadb36c9815e"
  instance_type           = "t2.micro"
  key_name = var.key_pair_id
  tags = {
    Name = "${var.env}-web"
  }
}
