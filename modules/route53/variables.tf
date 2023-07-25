variable "domain" {
  type = string
}

variable "ec2_eip" {
  type = object({
    public_ip = string
  })
}

variable "rds_endpoint" {
  type = string
}

variable "lb" {
  type = object({
    dns_name = string
    zone_id  = string
  })
}
