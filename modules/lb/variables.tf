variable "app_name_dash" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "acm_external_ssl_certificate_arn" {
  type = string
}
