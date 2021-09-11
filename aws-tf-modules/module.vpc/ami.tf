####################################################
#             Bastion host AMI config              #
####################################################
locals {
  ami_filter_prefix = var.ami_filter_type == "self" ? "bastion-host-*" : "amzn2-ami-*-x86_64-gp2"
}

data "aws_ami" "bastion" {
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
