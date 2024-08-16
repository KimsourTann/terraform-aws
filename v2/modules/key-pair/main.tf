resource "aws_key_pair" "public_key" {
  key_name = "public keypair"
  public_key = tls_private_key.rsa_4096.public_key_openssh
  tags = {
    Name = "${var.env}-public-keypair"
  }
}

resource "local_file" "private_key" {
  content = tls_private_key.rsa_4096.private_key_pem
  filename = "public keypair"
}

resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA" 
  rsa_bits = "4096"
}