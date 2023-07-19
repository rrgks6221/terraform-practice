resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "terraform-practice"
  }
}

resource "aws_subnet" "public" {
  for_each          = var.public_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["zone"]

  tags = {
    Name = "terraform-practice-pubilc-subnet"
  }
}

resource "aws_subnet" "private_ec2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    "Name" = "private-subnet-for-public-ec2"
  }
}

resource "aws_subnet" "private_rds" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-2b"

  tags = {
    "Name" = "private-subnet-for-main-rds"
  }
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.private_ec2.id, aws_subnet.private_rds.id]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-practice-public-route-table"
  }
}

resource "aws_route_table" "private_ec2" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "private-route-for-ec2"
  }
}

resource "aws_route_table" "private_rds" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "private-route-for-rds"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = var.public_subnets
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_ec2" {
  subnet_id      = aws_subnet.private_ec2.id
  route_table_id = aws_route_table.private_ec2.id
}

resource "aws_route_table_association" "private_rds" {
  subnet_id      = aws_subnet.private_rds.id
  route_table_id = aws_route_table.private_rds.id
}
