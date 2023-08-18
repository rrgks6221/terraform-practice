resource "aws_ecr_repository" "ecr_main" {
  name                 = var.app_name_dash
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
