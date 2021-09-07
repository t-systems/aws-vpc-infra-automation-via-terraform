provider "aws" {
  region  = var.default_region
  profile = "default"

  version = ">=2.22.0"
}

terraform {
  required_version = ">= 0.13"

}

data "aws_caller_identity" "current" {}
