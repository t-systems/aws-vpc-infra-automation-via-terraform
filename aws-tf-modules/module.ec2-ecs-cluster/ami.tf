locals {
  ami_filter_prefix = var.ami_filter_type == "self" ? "ecs-ami-*" : "*amazon-ecs-optimized"
}

data "aws_ami" "ecs-node-ami" {
  most_recent = true
  owners      = [var.ami_filter_type]

  filter {
    name   = "name"
    values = [local.ami_filter_prefix]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

