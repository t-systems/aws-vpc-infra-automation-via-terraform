################################################
# Global variables for TF Configuration        #
################################################
variable "default_region" {
  type        = string
  description = "AWS region to deploy resources"
}

#####==================================S3 Bucket Configuration Variable============================#####
variable "bucket_config" {
  type = map(object({
    bucket_prefix       = string
    bucket_acl          = string
    fore_destroy        = bool
    acceleration_status = string
    sse_algorithm       = string
    kms_master_key_id   = string
    enable_versioning   = bool

    infrequent_transition_enabled = bool
    infrequent_transition_prefix = string
    infrequent_transition_days = number

    glacier_transition_enabled = bool
    glacier_transition_prefix = string
    glacier_transition_days = number

    expiry_enabled = bool
    expiry_prefix = string
    expiry_days = number
    noncurrent_expiry_days = number
  }))

  description = "S3 bucket configuration to dynamically create multiple buckets.\n "
                 + " Valid values for 'sse_algorithm' are AES256 and aws:kms \n "
                  + " Valid values for 'acceleration_status' Enabled or Suspended \n "
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