module "vpc_main" {
  source = "./modules/vpc"

  public_subnets = var.public_subnets
  vpc_cidr       = var.vpc_cidr
}

module "ec2_security_group" {
  source = "./modules/security_group"

  vpc_id = module.vpc_main.vpc_id
}

module "ec2_public" {
  source = "./modules/ec2"

  public_subnet_ids       = module.vpc_main.public_subnet_ids
  ec2_security_group_id   = module.ec2_security_group.ec2_security_group_id
  ec2_security_group_name = module.ec2_security_group.ec2_security_group_name
}
