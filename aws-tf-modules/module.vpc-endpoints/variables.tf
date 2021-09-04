###############################
#    Global variables         #
###############################
variable "default_region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "tfstate_s3_bucket_prefix" {
  type = string
  description = "S3 name prefix of bucket where TF state files are stored"
}

######################################################
# Local variables defined                            #
######################################################
variable "team" {
  type        = string
  description = "Owner team for this application infrastructure"
}

variable "owner" {
  type        = string
  description = "Owner of the product"
}

variable "environment" {
  type        = string
  description = "Environment to be used valid values: 'dev', 'qa', 'prod'"
}

variable "isMonitoring" {
  type        = bool
  description = "Monitoring is enabled or disabled for the resources creating"
}

variable "project" {
  type        = string
  description = "Monitoring is enabled or disabled for the resources creating"
}


#####=============Local variables===============#####
locals {
  common_tags = {
    owner       = var.owner
    team        = var.team
    environment = var.environment
    monitoring  = var.isMonitoring
    Project     = var.project
  }
}