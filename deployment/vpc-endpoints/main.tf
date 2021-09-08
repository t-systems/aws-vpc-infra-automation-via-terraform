####################################################
#        VPC Endpoint Resources Module             #
####################################################
module "vpc_endpoint_resources" {
  source = "../../aws-tf-modules/module.vpc-endpoints"

  default_region = var.default_region

  team         = var.team
  owner        = var.owner
  environment  = var.environment
  isMonitoring = var.isMonitoring
  project      = var.project
}