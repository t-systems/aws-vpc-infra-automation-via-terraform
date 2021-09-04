provider "aws" {
  region  = var.default_region
//  profile = "default"               # un-comment to run from local

  version = ">=2.22.0"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
//    profile        = "default"      # un-comment to run from local
    region         = "us-east-1"
    encrypt        = "true"
  }
}

data "aws_caller_identity" "current" {}
