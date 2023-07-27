resource "aws_security_group" "api_lb" {
  name        = "${var.app_name_dash}-api"
  description = "${var.app_name_dash} api LB SG"
  vpc_id      = var.vpc_id

  tags = {
    "Name" = "${var.app_name_dash}-api-lb"
  }
}

resource "aws_security_group_rule" "api_lb_http_ingress" {
  description       = "${var.app_name_dash}-api-lb-http-ingress"
  type              = "ingress"
  security_group_id = aws_security_group.api_lb.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "api_lb_https_ingress" {
  description       = "${var.app_name_dash}-api-lb-https-ingress"
  type              = "ingress"
  security_group_id = aws_security_group.api_lb.id

  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "internal_api_egress" {
  description       = "${var.app_name_dash}-api-lb-egress"
  type              = "egress"
  security_group_id = aws_security_group.api_lb.id

  from_port   = 3000
  to_port     = 3000
  protocol    = "tcp"
  cidr_blocks = [var.vpc_cidr]
}
