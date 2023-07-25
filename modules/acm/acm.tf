resource "aws_acm_certificate" "awspractice_shop" {
  domain_name       = var.domain
  validation_method = "DNS"

  tags = {
    "Name" = "${var.app_name_dash}-acm"
  }
}

resource "aws_acm_certificate" "api_awspractice_shop" {
  domain_name       = "api.${var.domain}"
  validation_method = "DNS"

  tags = {
    "Name" = "api-${var.app_name_dash}-acm"
  }
}
