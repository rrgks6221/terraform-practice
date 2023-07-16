variable "public_subnets" {
  type = map(map(string))
}

variable "vpc_cidr" {
  type = string
}
