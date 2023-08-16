resource "aws_security_group" "ec2_free_tier" {
  name   = "ec2 free tier sg"
  vpc_id = var.vpc_id

  tags = {
    "Name" = "${var.app_name_dash}-ec2-free-tier-security-group"
  }
}

resource "aws_security_group_rule" "ssh_ingress" {
  description       = "${var.app_name_dash}-ssh-ingress"
  type              = "ingress"
  security_group_id = aws_security_group.ec2_free_tier.id

  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http_ingress" {
  description       = "${var.app_name_dash}-http-ingress"
  type              = "ingress"
  security_group_id = aws_security_group.ec2_free_tier.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https_ingress" {
  description       = "${var.app_name_dash}-https-ingress"
  type              = "ingress"
  security_group_id = aws_security_group.ec2_free_tier.id

  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ec2_free_tier_was_ingress" {
  description       = "${var.app_name_dash}-ec2-free-tier-was-ingress"
  type              = "ingress"
  security_group_id = aws_security_group.ec2_free_tier.id

  from_port   = 3000
  to_port     = 3000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# resource "aws_security_group_rule" "ec2_tunneling_ingress" {
#   description       = "${var.app_name_dash}-ec2-free-tier-tunneling-ingress-ingress"
#   type              = "ingress"
#   security_group_id = aws_security_group.ec2_free_tier.id

#   from_port   = 13336
#   to_port     = 13336
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
# }

resource "aws_security_group_rule" "all_egress" {
  description       = "${var.app_name_dash}-all-egress"
  type              = "egress"
  security_group_id = aws_security_group.ec2_free_tier.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
