########################################################
#    Key pair to be used for different applications    #
########################################################
resource "aws_key_pair" "bastion_key" {
  public_key = var.public_key
  key_name   = "bastion-key"
}


##################################################################
#   Bastion host launch configuration and act as Jump Instance   #
##################################################################
resource "aws_launch_configuration" "bastion_launch_conf" {
  name_prefix = "bastion-"

  image_id                    = data.aws_ami.bastion.id
  instance_type               = var.bastion_instance_type
  iam_instance_profile        = aws_iam_instance_profile.bastion_host_profile.name
  key_name                    = aws_key_pair.bastion_key.key_name
  security_groups             = [aws_security_group.bastion_host_sg.id]
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

#################################################
#         Bastion host ASG                      #
#################################################
resource "aws_autoscaling_group" "bastion_asg" {
  name = "bastion-asg-${aws_launch_configuration.bastion_launch_conf.name}"

  launch_configuration = aws_launch_configuration.bastion_launch_conf.name
  vpc_zone_identifier  = aws_subnet.public.*.id
  max_size             = 2
  min_size             = 1
  desired_capacity     = 1

  lifecycle {
    create_before_destroy = true
  }

  dynamic "tag" {
    for_each = var.custom_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
