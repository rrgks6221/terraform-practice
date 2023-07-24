resource "aws_lb" "external" {
  name     = "${var.app_name_dash}-external-lb"
  subnets  = var.public_subnet_ids
  internal = false

  security_groups = [aws_security_group.external_lb.id]

  load_balancer_type = "application"

  tags = {
    "Name" = "${var.app_name_dash}-external-lb"
  }
}

resource "aws_lb_target_group" "external" {
  name     = "${var.app_name_dash}-ex-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  tags = {
    "Name" = "${var.app_name_dash}-external-lb-target-group"
  }
}

resource "aws_lb_listener" "name" {
  load_balancer_arn = aws_lb.external.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.external.arn
    type             = "forward"
  }
}
