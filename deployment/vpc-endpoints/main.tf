####################################################
#        VPC Endpoint Resources Module             #
####################################################
module "vpc_endpoint_resources" {
  source = "../../aws-tf-modules/module.vpc-endpoints"

  default_region = var.default_region
  tfstate_s3_bucket_prefix = var.tfstate_s3_bucket_prefix

  team         = var.team
  owner        = var.owner
  environment  = var.environment
  isMonitoring = var.isMonitoring
  project      = var.project
}