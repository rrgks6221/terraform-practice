resource "aws_s3_bucket" "main" {
  bucket = "seokho-${var.app_name_dash}"

  tags = {
    "Name" = "seokho-${var.app_name_dash}"
  }
}
