####################################################
#             Reading VPC TF SateFile              #
####################################################
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "${var.tfstate_s3_bucket_prefix}-tfstate-${var.default_region}"
    key     = "state/${var.environment}/vpc/terraform.tfstate"
    region  = var.default_region
  }
}