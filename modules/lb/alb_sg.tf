resource "aws_security_group" "external_lb" {
  name        = "${var.app_name_dash}-external"
  description = "${var.app_name_dash} external LB SG"
  vpc_id      = var.vpc_id

  tags = {
    "Name" = "${var.app_name_dash}-external-lb"
  }
}

resource "aws_security_group_rule" "http_ingress" {
  description       = "${var.app_name_dash}-http-ingress"
  type              = "ingress"
  security_group_id = aws_security_group.external_lb.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https_ingress" {
  description       = "${var.app_name_dash}-https-ingress"
  type              = "ingress"
  security_group_id = aws_security_group.external_lb.id

  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "internal_all_egress" {
  description       = "${var.app_name_dash}-all-egress"
  type              = "egress"
  security_group_id = aws_security_group.external_lb.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = [var.vpc_cidr]
}
