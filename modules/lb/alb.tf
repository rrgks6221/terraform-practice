resource "aws_lb" "api" {
  name     = "${var.app_name_dash}-api-lb"
  subnets  = var.public_subnet_ids
  internal = false

  security_groups = [aws_security_group.api_lb.id]

  load_balancer_type = "application"

  tags = {
    "Name" = "${var.app_name_dash}-api-lb"
  }
}

resource "aws_lb_target_group" "api" {
  name     = "${var.app_name_dash}-ex-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  tags = {
    "Name" = "${var.app_name_dash}-api-lb-target-group"
  }
}

resource "aws_lb_listener" "external_80" {
  load_balancer_arn = aws_lb.api.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.api.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "external_443" {
  load_balancer_arn = aws_lb.api.arn
  port              = "443"
  protocol          = "HTTPS"

  certificate_arn = var.api_awspractice_acm_ssl_arn

  default_action {
    target_group_arn = aws_lb_target_group.api.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "name" {
  target_group_arn = aws_lb_target_group.api.arn
  target_id        = var.ec2_id
  port             = 3000
}
