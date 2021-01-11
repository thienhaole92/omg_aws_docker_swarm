data "aws_availability_zones" "available" {}

module "vpc" {
  source = "./modules/vpc"

  application             = var.application
  cidr                    = var.vpc_cidr_block
  region                  = var.region
  key_name                = var.key_name
  controller_subnet_zones = var.controller_subnet_zones
  controller_subnet_cidr  = var.controller_subnet_cidr
  public_subnet_zone      = var.public_subnet_zone
  public_subnet_cidr      = var.public_subnet_cidr
  worker_count            = var.worker_count
  worker_subnet_zones     = var.worker_subnet_zones
  worker_subnet_cidr      = var.worker_subnet_cidr
  manager_count           = var.manager_count
  manager_subnet_zones    = var.manager_subnet_zones
  manager_subnet_cidr     = var.manager_subnet_cidr
}

module "bastion" {
  source = "./modules/bastion"

  region          = var.region
  key_name        = var.key_name
  application     = var.application
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnet_id
  connection_user = var.connection_user
  private_key     = file("${var.key_name}.pem")
}

module "controller" {
  source = "./modules/nodes/controller"

  region                = var.region
  key_name              = var.key_name
  application           = var.application
  vpc_id                = module.vpc.vpc_id
  controller_subnet_ids = module.vpc.controller_subnet_ids
}

module "manager" {
  source = "./modules/nodes/manager"

  region             = var.region
  key_name           = var.key_name
  application        = var.application
  vpc_id             = module.vpc.vpc_id
  manager_subnet_ids = module.vpc.manager_subnet_ids
}

module "worker" {
  source = "./modules/nodes/worker"

  region            = var.region
  key_name          = var.key_name
  application       = var.application
  vpc_id            = module.vpc.vpc_id
  worker_subnet_ids = module.vpc.worker_subnet_ids
}
