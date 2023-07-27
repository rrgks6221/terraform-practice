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

variable "api_awspractice_acm_ssl_arn" {
  type = string
}

variable "ec2_id" {
  type = string
}
