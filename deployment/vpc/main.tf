####################################################
#           VPC module deployment                  #
####################################################
module "vpc" {
  source = "../../aws-tf-modules/module.vpc"

  environment    = var.environment
  default_region = var.default_region

  cidr_block            = var.cidr_block
  private_azs_with_cidr = var.private_azs_with_cidr
  public_azs_with_cidr  = var.public_azs_with_cidr
  db_azs_with_cidr      = var.db_azs_with_cidr
  instance_tenancy      = var.instance_tenancy
  enable_dns            = var.enable_dns
  support_dns           = var.support_dns
  enable_nat_gateway    = var.enable_nat_gateway

  team         = var.team
  owner        = var.owner
  isMonitoring = var.isMonitoring
  project      = var.project

  bastion_instance_type = var.bastion_instance_type

  ami_filter_type = var.ami_filter_type
}
