####################################################
#        S3 Buckets Module Implementation          #
####################################################
module "s3_resources" {
  source = "../../aws-tf-modules/module.aws-s3-buckets"

  default_region = var.default_region

  team         = var.team
  owner        = var.owner
  environment  = var.environment
  isMonitoring = var.isMonitoring
  component    = var.component
  project      = var.project

  bucket_config = var.bucket_config
}