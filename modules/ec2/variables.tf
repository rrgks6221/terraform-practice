variable "app_name_dash" {
  type = string
}

variable "app_name_underbar" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "ec2_security_group_id" {
  type = string
}

variable "ec2_security_group_name" {
  type = string
}
