#################################################
#                  S3 Endpoint                  #
#################################################
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  service_name      = "com.amazonaws.${var.default_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = data.terraform_remote_state.vpc.outputs.private_rt

  tags = merge(local.common_tags, tomap("Name", "${var.environment}-s3-endpoint"))
}

#################################################
#                  AWS ECR VPC Endpoint         #
#################################################
resource "aws_vpc_endpoint" "private_link_ecr_api" {
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.default_region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.vpce.id]
  subnet_ids          = data.terraform_remote_state.vpc.outputs.private_subnets

  tags = merge(local.common_tags, tomap("Name", "${var.environment}-ecr-api-endpoint"))
}

resource "aws_vpc_endpoint" "private_link_ecr_dkr" {
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.default_region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.vpce.id]
  subnet_ids          = data.terraform_remote_state.vpc.outputs.private_subnets

  tags = merge(local.common_tags, tomap("Name", "${var.environment}-dkr-endpoint"))
}


#################################################
#                  AWS ECS VPC Endpoint         #
#################################################
resource "aws_vpc_endpoint" "private_link_ecs_agent" {
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.default_region}.ecs-agent"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.vpce.id]
  subnet_ids          = data.terraform_remote_state.vpc.outputs.private_subnets

  tags = merge(local.common_tags, tomap("Name", "${var.environment}-ecs-agent-endpoint"))
}

resource "aws_vpc_endpoint" "private_link_ecs_telemetry" {
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.default_region}.ecs-telemetry"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.vpce.id]
  subnet_ids          = data.terraform_remote_state.vpc.outputs.private_subnets

  tags = merge(local.common_tags, tomap("Name", "${var.environment}-ecs-telemetry-endpoint"))
}

resource "aws_vpc_endpoint" "private_link_ecs" {
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.default_region}.ecs"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.vpce.id]
  subnet_ids          = data.terraform_remote_state.vpc.outputs.private_subnets

  tags = merge(local.common_tags, tomap("Name", "${var.environment}-ecs-endpoint"))
}

#################################################
#              AWS CW Logs VPC Endpoint         #
#################################################
resource "aws_vpc_endpoint" "private_link_cw_logs" {
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.default_region}.logs"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.vpce.id]
  subnet_ids          = data.terraform_remote_state.vpc.outputs.private_subnets

  tags = merge(local.common_tags, tomap("Name", "${var.environment}-logs-endpoint"))
}


#################################################
#              AWS EC2 VPC Endpoint             #
#################################################
resource "aws_vpc_endpoint" "ec2" {
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  service_name        = "com.amazonaws.${var.default_region}.ec2"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = data.terraform_remote_state.vpc.outputs.private_subnets
  security_group_ids  = [aws_security_group.vpce.id]

  tags = merge(local.common_tags, tomap("Name", "${var.environment}-EC2-endpoint"))
}