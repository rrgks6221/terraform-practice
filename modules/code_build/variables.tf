variable "app_name_dash" {
  type = string
}

variable "s3" {
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

variable "docker_account" {
  type = map(string)
}
