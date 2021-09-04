####################################################
#        EC2 ECS Cluster Module Implementation     #
####################################################
module "vpc-es-cluster" {
  source = "../../aws-tf-modules/module.ec2-ecs-cluster"

  environment    = var.environment
  default_region = var.default_region
  tfstate_s3_bucket_prefix = var.tfstate_s3_bucket_prefix

  log_retention_days = var.log_retention_days
  instance_type      = var.instance_type
  key_name           = var.key_name
  max_price          = var.max_price
  volume_size        = var.volume_size

  default_target_group_port = var.default_target_group_port

  suspended_processes               = var.suspended_processes
  termination_policies              = var.termination_policies
  app_asg_min_size                  = var.app_asg_min_size
  app_asg_max_size                  = var.app_asg_max_size
  app_asg_desired_capacity          = var.app_asg_desired_capacity
  health_check_type                 = var.health_check_type
  app_asg_health_check_grace_period = var.app_asg_health_check_grace_period
  app_asg_wait_for_elb_capacity     = var.app_asg_wait_for_elb_capacity
  wait_for_capacity_timeout         = var.wait_for_capacity_timeout
  default_cooldown                  = var.default_cooldown

  custom_tags = var.custom_tags

  component_name = var.component_name

  isMonitoring = false
  owner = var.owner
  project = var.project
  team = var.team
}
