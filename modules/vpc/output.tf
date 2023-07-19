output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = values(aws_subnet.public)[*].id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.subnet_group.name
}
