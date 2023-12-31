locals {
  app_name_dash     = replace(var.app_name, " ", "-")
  app_name_underbar = replace(var.app_name, " ", "_")
}

module "vpc_main" {
  source = "./modules/vpc"

  public_subnets = var.public_subnets
  vpc_cidr       = var.vpc_cidr
}

module "ec2_public" {
  source = "./modules/ec2"

  app_name_dash     = local.app_name_dash
  app_name_underbar = local.app_name_underbar
  vpc_id            = module.vpc_main.vpc_id
  public_subnet_ids = module.vpc_main.public_subnet_ids
}

module "route53" {
  source = "./modules/route53"

  domain = var.domain
  ec2_eip = {
    public_ip = module.ec2_public.ec2_eip.public_ip
  }
  rds_endpoint = module.rds_main.rds_endpoint
  lb = {
    dns_name = module.external_lb.dns_name
    zone_id  = module.external_lb.zone_id
  }
}

module "rds_main" {
  source = "./modules/rds"

  app_name_dash     = local.app_name_dash
  vpc_id            = module.vpc_main.vpc_id
  subnet_group_name = module.vpc_main.db_subnet_group_name
  ec2_tunneling_ip  = module.ec2_public.ec2_private_ip
}

module "external_lb" {
  source = "./modules/lb"

  app_name_dash               = local.app_name_dash
  vpc_id                      = module.vpc_main.vpc_id
  vpc_cidr                    = var.vpc_cidr
  public_subnet_ids           = module.vpc_main.public_subnet_ids
  api_awspractice_acm_ssl_arn = module.acm.api_awspractice_shop.arn
  ec2_id                      = module.ec2_public.ec2_free_tier_id
}

module "acm" {
  source = "./modules/acm"

  domain        = var.domain
  app_name_dash = local.app_name_dash
  cert_fqdn     = module.route53.lb_fqdns
}

module "s3_main" {
  source = "./modules/s3"

  app_name_dash = local.app_name_dash
}

module "code_build" {
  source = "./modules/code_build"

  app_name_dash      = local.app_name_dash
  s3                 = module.s3_main.s3_main
  github_token       = var.github_token
  default_region     = var.default_region
  ecr_repository_uri = var.ecr_repository_uri
  app_env            = var.app_env
  docker_account     = var.docker_account
}

module "ecr_main" {
  source = "./modules/ecr"

  app_name_dash = local.app_name_dash
}
