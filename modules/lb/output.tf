output "dns_name" {
  value = aws_lb.external.dns_name
}

output "zone_id" {
  value = aws_lb.external.zone_id
}
