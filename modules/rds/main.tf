resource "aws_db_instance" "main" {
  identifier            = var.app_name_dash
  db_name               = "init_db"
  allocated_storage     = 20
  max_allocated_storage = 22
  engine                = "postgres"
  engine_version        = "15.3"
  instance_class        = "db.t3.micro"
  username              = "seokho"
  password              = "seokho_password"

  publicly_accessible     = false
  deletion_protection     = true
  apply_immediately       = true
  skip_final_snapshot     = true
  backup_retention_period = 7

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = var.subnet_group_name


  tags = {
    "Name" = "${var.app_name_dash}-main-database"
  }
}
