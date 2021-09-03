data "aws_ami" "ecs-node-ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["ecs-ami-*"]
  }
}

