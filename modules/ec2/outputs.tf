output "ec2_eip" {
  value = aws_eip.ec2_eip
}

output "ec2_private_ip" {
  value = aws_instance.free_tier.private_ip
}

output "ec2_free_tier_id" {
  value = aws_instance.free_tier.id
}
