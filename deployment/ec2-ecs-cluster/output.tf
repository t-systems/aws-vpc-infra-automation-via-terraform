output "ecs-cluster-log-group" {
  value       = module.vpc-es-cluster.ecs-cluster-log-group
  description = "AWS cloud-watch log group name"
}

output "ecs-clustser-name" {
  value       = module.vpc-es-cluster.ecs-clustser-name
  description = "AWS DD ECS cluster name"
}

output "ecs-cluster-lb-arn" {
  value       = module.vpc-es-cluster.ecs-cluster-lb-arn
  description = "ECS cluster load balancer ARN!"
}

output "ecs-cluster-id" {
  value       = module.vpc-es-cluster.ecs-cluster-id
  description = "AWS DD ECS Cluster id!"
}

output "alb-target-group-arn" {
  value = module.vpc-es-cluster.alb-target-group-arn
}

output "alb-listner-arn" {
  value = module.vpc-es-cluster.alb-listner-arn
}