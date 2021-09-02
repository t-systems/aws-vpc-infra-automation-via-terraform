#################################################
#       VPC Configuration                       #
#################################################
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.support_dns


  tags = merge(local.common_tags, map("Name", "vpc-${var.environment}-${var.cidr_block}"))
}

#######################################################
# Enable access to or from the Internet for instances #
# in public subnets using IGW                         #
#######################################################
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tags, map("Name", "igw-${var.environment}"))
}

########################################################################
# Route Table                                                          #
## Usually unecessary to explicitly create a Route Table in Terraform  #
## since AWS automatically creates and assigns a 'Main Route Table'    #
## whenever a VPC is created. However, in a Transit Gateway scenario,  #
## Route Tables are explicitly created so an extra route to the        #
## Transit Gateway could be defined                                    #
########################################################################
resource "aws_route_table" "vpc_main_rt" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(local.common_tags, map("Name", "vpc-${var.environment}-main-rt"))
}

resource "aws_main_route_table_association" "main_rt_vpc" {
  route_table_id = aws_route_table.vpc_main_rt.id
  vpc_id         = aws_vpc.vpc.id
}

