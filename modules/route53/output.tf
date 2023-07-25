output "lb_fqdns" {
  value = aws_route53_record.alb.fqdn
}
