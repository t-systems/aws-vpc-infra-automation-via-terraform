#####===================Global Variables====================#####
variable "default_region" {
  type        = string
  description = "AWS region to provision"
}

variable "environment" {
  type        = string
  description = "Development environment"
}


#####=============================Local Variables=====================#####
variable "component" {
  type        = string
  description = "Name for the component or project for with infra is provisioned"
}

variable "team" {
  type        = string
  description = "Project owner mailId / owner"
}

#####==============Local variables======================#####
locals {
  common_tags = {
    team        = var.team
    environment = var.environment
    component   = var.component
  }
}

