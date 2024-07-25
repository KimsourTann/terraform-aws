

resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "key-pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

resource "local_file" "private_key" {
  content = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
}


resource "aws_instance" "web-app" {
  ami           = "ami-04b70fa74e45c3917" //Ubuntu image-id
  instance_type = "t2.micro"
  key_name = aws_key_pair.key-pair.key_name
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              echo "Hello, World!" > /var/www/html/index.html
              systemctl start apache2
              systemctl enable apache2
              EOF
  tags = {
    Name = "demo-web-app"
  }
}