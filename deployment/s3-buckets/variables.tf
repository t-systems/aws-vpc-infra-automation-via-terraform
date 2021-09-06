################################################
# Global variables for TF Configuration        #
################################################
variable "default_region" {
  type        = string
  description = "AWS region to deploy resources"
}

#############################################
#        Variable for TF resources          #
#############################################
variable "artifactory_bucket_prefix" {
  type        = string
  description = "S3 bucket store deployment packages"
}

variable "dataLake_bucket_prefix" {
  type        = string
  description = "Bucket to store data"
}

variable "logging_bucket_prefix" {
  type        = string
  description = "Bucket to store logging data"
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
  description = "Environment to be used"
}

variable "isMonitoring" {
  type        = bool
  description = "Monitoring is enabled or disabled for the resources creating"
}

variable "project" {
  type        = string
  description = "Monitoring is enabled or disabled for the resources creating"
}

variable "component" {
  type        = string
  description = "Component name for the resource"
}


#####=============Local variables===============#####
locals {
  common_tags = {
    Owner       = var.owner
    Team        = var.team
    Environment = var.environment
    Monitoring  = var.isMonitoring
    Project     = var.project
    Component   = var.component
  }
}