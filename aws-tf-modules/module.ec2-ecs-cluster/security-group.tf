#############################################
#      Security Group for ECS Instance      #
#############################################
resource "aws_security_group" "ecs_instance_sg" {
  name        = "monitoring-app-sg"
  description = "Allow traffic from port elb and enable SSH"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  lifecycle {
    create_before_destroy = true
  }
  tags = merge(local.common_tags, map("Name", "monitoring-app-ec2-sg"))
}

resource "aws_security_group_rule" "allow_traffic_from_lb" {
  type                     = "ingress"
  from_port                = 1024
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_instance_sg.id
  source_security_group_id = aws_security_group.ecs_alb_sg.id
}

resource "aws_security_group_rule" "allow_ssh_traffic" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_instance_sg.id
  source_security_group_id = data.terraform_remote_state.vpc.outputs.bastion_sg
}

resource "aws_security_group_rule" "master_outbound_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.ecs_instance_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}


#############################################
#      Security Group for ECS ALB           #
#############################################
resource "aws_security_group" "ecs_alb_sg" {
  name        = "ecs-alb-sg"
  description = "Allow traffic from port 80"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  lifecycle {
    create_before_destroy = true
  }
  tags = merge(local.common_tags, map("Name", "ecs-cluster-alb-sg"))
}

resource "aws_security_group_rule" "allow_http_traffic" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.ecs_alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_https_traffic" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.ecs_alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_master_outbound_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.ecs_alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

