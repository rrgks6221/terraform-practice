resource "aws_db_instance" "main" {
  identifier            = "terraform-practice"
  db_name               = "init_db"
  allocated_storage     = 20
  max_allocated_storage = 22
  engine                = "postgres"
  engine_version        = "15.3"
  instance_class        = "db.t3.micro"
  username              = "seokho"
  password              = "seokho_password"
  publicly_accessible   = true

  deletion_protection = false
  apply_immediately   = true

  vpc_security_group_ids = [var.security_group_id]

  tags = {
    "Name" = "main-database"
  }
}
