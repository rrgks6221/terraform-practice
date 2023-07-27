# AWS Route53 Zone
resource "aws_route53_zone" "awspractice_shop" {
  # awspractice.shop
  name    = var.domain
  comment = "awspractice.com HostedZone created by Route53 Registrar"
}

resource "aws_route53_record" "alb_api" {
  zone_id = aws_route53_zone.awspractice_shop.id
  name    = "api.${var.domain}"
  type    = "A"

  alias {
    name                   = var.lb.dns_name
    zone_id                = var.lb.zone_id
    evaluate_target_health = true
  }
}

# resource "aws_route53_record" "api" {
#   zone_id = aws_route53_zone.awspractice_shop.id
#   name    = "api.${var.domain}"
#   type    = "A"
#   ttl     = 300

#   records = [var.ec2_eip.public_ip]
# }


# resource "aws_route53_record" "alb" {
#   zone_id = aws_route53_zone.awspractice_shop.id
#   name    = var.domain
#   type    = "A"

#   alias {
#     name                   = var.lb.dns_name
#     zone_id                = var.lb.zone_id
#     evaluate_target_health = true
#   }
# }
