# Create Load Balancer
resource "aws_lb" "lb" {
  name = "${var.name}-lb"
  internal = false
  load_balancer_type = var.type
  security_groups = var.security_groups
  subnets = var.subnets
  # depends_on = var.depends
}

# Target Group for ALB
resource "aws_lb_target_group" "alb_tg" {
  name = "${var.name}-tg"
  port = "80"
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

# # Target Group for ALB
# resource "aws_lb_target_group" "alb_https_tg" {
#   name = "${var.name}-tg"
#   port = "443"
#   protocol = "HTTPS"
#   vpc_id = var.vpc_id
# }

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}