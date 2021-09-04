###################################################
#          Fetch TF remote state of VPC           #
###################################################
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "${var.tfstate_s3_bucket_prefix}-tfstate-${var.default_region}"
    key     = "state/${var.environment}/vpc/terraform.tfstate"
    region  = var.default_region
  }
}

#######################################################
#    Fetch TF remote state of VPC-Endpoints           #
#######################################################
data "terraform_remote_state" "vpc-resources" {
  backend = "s3"

  config = {
    bucket  = "${var.tfstate_s3_bucket_prefix}-tfstate-${var.default_region}"
    key     = "state/${var.environment}/vpc-endpoints/terraform.tfstate"
    region  = var.default_region
  }
}


data "template_file" "ecs_instance_policy_template" {
  template = file("${path.module}/policy-doc/ecs-ec2-policy.json")
}

data "template_file" "ec2_user_data" {
  template = file("${path.module}/scripts/ec2-user-data-temp.sh")

  vars = {
    health_monitoring_cluster = aws_ecs_cluster.test_ecs_cluster.name
  }
}

# Currently not is use
data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

data "aws_caller_identity" "current" {}
