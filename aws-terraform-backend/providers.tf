provider "aws" {
  region  = var.default_region
#  profile = "default"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=3.3.0"
    }
  }

  required_version = ">= 0.13"

  backend "s3" {
#    profile        = "default"
    region         = "us-east-1"
    encrypt        = "true"
  }
}

data "aws_caller_identity" "current" {}
