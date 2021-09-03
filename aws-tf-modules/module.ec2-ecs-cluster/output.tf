output "ecs-cluster-log-group" {
  value       = aws_cloudwatch_log_group.dd_ecs_cluster_log_group.name
  description = "AWS cloud-watch log group name"
}

output "ecs-clustser-name" {
  value       = aws_ecs_cluster.dd_ecs_cluster.name
  description = "AWS DD ECS cluster name"
}

output "ecs-cluster-lb-arn" {
  value       = aws_alb.ecs_cluster_alb.arn
  description = "ECS cluster load balancer ARN!"
}

output "ecs-cluster-id" {
  value       = aws_ecs_cluster.dd_ecs_cluster.id
  description = "AWS DD ECS Cluster id!"
}

output "alb-target-group-arn" {
  value = aws_lb_target_group.ecs_alb_default_target_group.arn
}

output "alb-listner-arn" {
  value = aws_lb_listener.ecs_alb_listener.arn
}

output "ecs_optimized_ami" {
  value = data.aws_ssm_parameter.ecs_ami.value
}
