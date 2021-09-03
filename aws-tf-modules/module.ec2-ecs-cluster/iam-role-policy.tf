###########################################################
#           ECS Instance Role & Policy                    #
###########################################################
resource "aws_iam_role" "ecs_instance_role" {

  name               = "TestECSClusterInstanceRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}


resource "aws_iam_policy" "ecs_instance_policy" {
  name        = "TestECSClusterInstanceRolePolicy"
  description = "Policy to access ECR, EC2 and Logs"
  path        = "/"
  policy      = data.template_file.ecs_instance_policy_template.rendered
}


resource "aws_iam_role_policy_attachment" "ecs_instance_role_att" {
  policy_arn = aws_iam_policy.ecs_instance_policy.arn
  role       = aws_iam_role.ecs_instance_role.name
}


resource "aws_iam_instance_profile" "ecs_cluster_instance_profile" {
  name = "TestECSClusterInstanceProfile"
  role = aws_iam_role.ecs_instance_role.name
}