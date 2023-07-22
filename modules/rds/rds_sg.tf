resource "aws_security_group" "rds" {
  name   = "rds sg"
  vpc_id = var.vpc_id

  tags = {
    "Name" = "${var.app_name_dash}-rds-security-group"
  }
}

resource "aws_security_group_rule" "rds_tunneling_ingress" {
  description       = "${var.app_name_dash}-rds-tunnerling-ingress"
  type              = "ingress"
  security_group_id = aws_security_group.rds.id

  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"
  # cidr_blocks = ["0.0.0.0/0"]
  cidr_blocks = ["${var.ec2_tunneling_ip}/32"]
}
