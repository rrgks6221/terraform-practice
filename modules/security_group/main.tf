locals {
  http_port     = 80
  https_port    = 443
  ssh_port      = 22
  any_port      = 0
  postgres_port = 5432
  was_port      = 3000

  tcp_protocol = "tcp"
  any_protocol = "-1"

  all_ips = ["0.0.0.0/0"]
}

resource "aws_security_group" "ec2_sg" {
  vpc_id      = var.vpc_id
  name        = "ec2 security group"
  description = "ec2 security group"

  tags = {
    Name = "ec2 security group"
  }
}

resource "aws_security_group_rule" "ec2_was" {
  type              = "ingress"
  security_group_id = aws_security_group.ec2_sg.id

  from_port   = local.was_port
  to_port     = local.was_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips

  description = "ec2_was"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.ec2_sg.id

  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_https_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.ec2_sg.id

  from_port   = local.https_port
  to_port     = local.https_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_ssh_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.ec2_sg.id

  from_port   = local.ssh_port
  to_port     = local.ssh_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.ec2_sg.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "ec2_tunneling_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.ec2_sg.id

  from_port   = 13306
  to_port     = 13306
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "ec2_tunneling_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.ec2_sg.id

  from_port   = local.postgres_port
  to_port     = local.postgres_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group" "rds_sg" {
  vpc_id      = var.vpc_id
  name        = "rds security group"
  description = "rds security group"

  tags = {
    "Name" = "rds security group"
  }
}

resource "aws_security_group_rule" "rds_tunneling_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.rds_sg.id

  from_port   = local.postgres_port
  to_port     = local.postgres_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}
