# AWS Route53 Zone
resource "aws_route53_zone" "awspractice_shop" {
  # awspractice.shop
  name    = var.domain
  comment = "awspractice.com HostedZone created by Route53 Registrar"
}

resource "aws_route53_record" "api_aws_practice_shop" {
  zone_id = aws_route53_zone.awspractice_shop.id
  name    = "api.${var.domain}"
  type    = "A"
  ttl     = 300

  records = [var.ec2_eip.public_ip]
}

resource "aws_route53_record" "rds_aws_practice_shop" {
  zone_id = aws_route53_zone.awspractice_shop.id
  name    = "rds.${var.domain}"
  type    = "CNAME"
  ttl     = 300

  records = [var.rds_endpoint]
}
