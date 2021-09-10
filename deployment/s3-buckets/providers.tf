####################################################
# AWS provider configuration                       #
####################################################
provider "aws" {
  region = var.default_region
#  profile = "default"
}


#############################################################
# Terraform configuration block is used to define providers #
#############################################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 1.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.1"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }
  }
  required_version = ">= 0.13"


  backend "s3" {
#    profile = "default"
    region  = "us-east-1"
    encrypt = "true"
  }

}

# used for accessing Account ID and ARN
data "aws_caller_identity" "current" {}
