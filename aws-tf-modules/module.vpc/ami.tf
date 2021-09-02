####################################################
#             Bastion host AMI config              #
####################################################
data "aws_ami" "bastion" {
  owners      = ["self"]
  most_recent = true

  filter {
    name   = "name"
    values = ["bastion-host"]
  }
}