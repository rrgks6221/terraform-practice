# AWS Route53 Zone
resource "aws_route53_zone" "awspractice_com" {
  # awspractice.shop
  name    = var.domain
  comment = "awspractice.com HostedZone created by Route53 Registrar"
}
