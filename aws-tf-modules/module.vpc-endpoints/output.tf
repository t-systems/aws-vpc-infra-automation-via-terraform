output "vpce_sg" {
  value = aws_security_group.vpce.id
}

output "ecs_task_sg" {
  value = aws_security_group.ecs_task.id
}

output "vpc_s3_endpoint" {
  value = aws_vpc_endpoint.s3_endpoint.id
}

output "vpc_logs_endpoint" {
  value = aws_vpc_endpoint.private_link_cw_logs.id
}