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
