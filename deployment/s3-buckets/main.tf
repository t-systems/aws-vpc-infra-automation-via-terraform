####################################################
#        S3 Buckets Module Implementation          #
####################################################
module "s3_resources" {
  source = "../../aws-tf-modules/module.aws-s3-buckets"

  default_region = var.default_region

  artifactory_bucket_prefix = var.artifactory_bucket_prefix
  logging_bucket_prefix     = var.logging_bucket_prefix
  dataLake_bucket_prefix    = var.dataLake_bucket_prefix

  team         = var.team
  owner        = var.owner
  environment  = var.environment
  isMonitoring = var.isMonitoring
  component    = var.component
  project      = var.project
}