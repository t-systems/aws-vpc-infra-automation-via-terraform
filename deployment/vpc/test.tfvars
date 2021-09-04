default_region = "us-east-1"

cidr_block         = "10.0.16.0/20"           # 4096 IPs, 10.0.16.0 - 10.0.31.255
instance_tenancy   = "default"
enable_dns         = "true"
support_dns        = "true"
enable_nat_gateway = "true"


private_azs_with_cidr = {
  us-east-1a = "10.0.16.0/24"                 # 256 IPs
  us-east-1b = "10.0.18.0/24"
  us-east-1c = "10.0.20.0/24"
}

public_azs_with_cidr = {
  us-east-1a = "10.0.17.0/24"
  us-east-1b = "10.0.19.0/24"
  us-east-1c = "10.0.21.0/24"
}

db_azs_with_cidr = {
  us-east-1a = "10.0.22.0/24"
  us-east-1b = "10.0.24.0/24"
  us-east-1c = "10.0.26.0/24"
}


team                  = "LearningTeam"
owner                 = "Vivek"
bastion_instance_type = "t3a.small"
isMonitoring          = true
project               = "Learning-TF"