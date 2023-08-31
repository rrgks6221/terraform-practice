variable "app_name" {
  type = string
}

variable "domain" {
  type = string
}

variable "vpc_cidr" {

}

variable "public_subnets" {

}

variable "github_token" {
  type = string
}

variable "default_region" {
  type = string
}

variable "ecr_repository_uri" {
  type = string
}

variable "app_env" {
  type = map(string)
}
