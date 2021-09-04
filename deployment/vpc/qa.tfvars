default_region = "us-east-1"

cidr_block         = "10.0.0.0/20"
instance_tenancy   = "default"
enable_dns         = "true"
support_dns        = "true"
enable_nat_gateway = "true"


private_azs_with_cidr = {
  us-east-1a = "10.0.0.0/24"
  us-east-1b = "10.0.2.0/24"
  us-east-1c = "10.0.4.0/24"
}

public_azs_with_cidr = {
  us-east-1a = "10.0.1.0/24"
  us-east-1b = "10.0.3.0/24"
  us-east-1c = "10.0.5.0/24"
}

db_azs_with_cidr = {
  us-east-1a = "10.0.6.0/24"
  us-east-1b = "10.0.7.0/24"
  us-east-1c = "10.0.8.0/24"
}


team                  = "LearningTeam"
owner                 = "Vivek"
bastion_instance_type = "t3a.small"
isMonitoring          = true
project               = "Learning-TF"