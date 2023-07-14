/*#################################
  Terraform 설정(버전, provider 버전)
#################################*/
terraform {
  required_version = "1.5.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }
  }
}

/*#################################
  Provider설정(사용리전 등록)
#################################*/
provider "aws" {
  region                   = "ap-northeast-2"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "terraform-practice"
}
