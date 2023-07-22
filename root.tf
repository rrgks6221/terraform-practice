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
}

module "rds_main" {
  source = "./modules/rds"

  app_name_dash     = local.app_name_dash
  vpc_id            = module.vpc_main.vpc_id
  subnet_group_name = module.vpc_main.db_subnet_group_name
}
