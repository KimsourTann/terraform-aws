# Create a Security Group
resource "aws_security_group" "main" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingressess
    content {
      from_port = ingress.key
      to_port = ingress.key
      protocol = "tcp"
      cidr_blocks = ingress.value
    }
  }

  dynamic "egress" {
    for_each = var.egressess
    content {
      from_port = egress.key
      to_port = egress.key
      protocol = "-1"
      cidr_blocks = egress.value
    }
  }
  tags = {
    Name = "main-security-group"
  }
}

