######################################################################
# Global variables for VPC, Subnet, Routes and Bastion Host          #
######################################################################
variable "profile" {
  type        = string
  description = "AWS Profile name for credentials"
}

variable "default_region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "cidr_block" {
  type        = string
  description = "Cidr range for vpc"
}

variable "instance_tenancy" {
  type        = string
  description = "Type of instance tenancy required default/dedicated"
}

variable "enable_dns" {
  type        = string
  description = "To use private DNS within the VPC"
}

variable "support_dns" {
  type        = string
  description = "To use private DNS support within the VPC"
}

variable "private_azs_with_cidr" {
  type        = map(string)
  description = "Name of azs with cidr to be used for infrastructure"
}

variable "public_azs_with_cidr" {
  type        = map(string)
  description = "Name of azs with cidr to be used for infrastructure"
}

variable "db_azs_with_cidr" {
  type        = map(string)
  description = "Name of azs with cidr to be used for Database infrastructure"
}

variable "enable_nat_gateway" {
  type        = string
  description = "want to create nat-gateway or not"
}

variable "bastion_instance_type" {
  type        = string
  description = "Instance type for Bastion Host"
}

#########################################################
# Default variables for backend and SSH key for Bastion #
#########################################################
variable "s3_bucket_prefix" {
  type        = string
  default     = "learning-tfstate"
  description = "Prefix for s3 bucket where we store TF state file"
}

variable "public_key" {
  type        = string
  description = "key pair value"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDV3fznjm92/s10goG0YotNIjq66CTDyf5a6wVVQUDYIF4OziH9G81NNc9sQiTlfNFy8RO4kSB0n5+w9nt90gs7nSZoBAATK6T0YNHll/A6ISUv4hgwooa6XUYxFgg+ceZ8Mvxc36wx78wTieVc7RTbx74Wr8AtavSJMC8wVb8QkUGMpumH7TNPP356MYEEgYciRLE8sLnkRYOvVekL3iU8p1tS5Pny5mqR1hinbQoE7WNuDsBxgV6Xn9kRQ9Rn5seIyY55tc1HPd2fwkafidWVX3hUD8RwOfSYvAwPc7AmVLCbUCktSZ8S1FEV9dSVncd8ji1tguoHh/OquXzNckqJ vivek@LAPTOP-FLDAPLLM"
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

#####=============ASG Standards Tags===============#####
variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default = {
    owner      = "vivek"
    tool       = "Terraform"
    monitoring = "true"
    Name       = "Bastion-Host"
    Project    = "Learning-TF"
  }
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