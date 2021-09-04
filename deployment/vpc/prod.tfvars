default_region = "us-east-1"

cidr_block         = "10.0.32.0/20"              # 4096 IPs, 10.0.32.0 - 10.0.47.255
instance_tenancy   = "default"
enable_dns         = "true"
support_dns        = "true"
enable_nat_gateway = "true"


private_azs_with_cidr = {
  us-east-1a = "10.0.32.0/24"                     # 256 IPs
  us-east-1b = "10.0.34.0/24"
  us-east-1c = "10.0.36.0/24"
}

public_azs_with_cidr = {
  us-east-1a = "10.0.33.0/24"
  us-east-1b = "10.0.35.0/24"
  us-east-1c = "10.0.37.0/24"
}

db_azs_with_cidr = {
  us-east-1a = "10.0.38.0/24"
  us-east-1b = "10.0.40.0/24"
  us-east-1c = "10.0.42.0/24"
}


team                  = "LearningTeam"
owner                 = "Vivek"
isMonitoring          = true
project               = "Learning-TF"
bastion_instance_type = "t3a.small"
