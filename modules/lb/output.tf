output "dns_name" {
  value = aws_lb.api.dns_name
}

output "zone_id" {
  value = aws_lb.api.zone_id
}
