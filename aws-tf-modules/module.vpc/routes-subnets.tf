######################################################
# NAT gateways  enable instances in a private subnet #
# to connect to the Internet or other AWS services,  #
# but prevent the internet from initiating           #
# a connection with those instances.                 #
#                                                    #
# Each NAT gateway requires an Elastic IP.           #
######################################################
resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.vpc_igw]

  vpc   = true
  count = var.enable_nat_gateway == "true" ? 1 : 0

  tags = {
    Name = "eip-${var.environment}-${aws_vpc.vpc.id}-${count.index}"
  }
}


#################################################
#       Create NatGateway and allocate EIP      #
#################################################
resource "aws_nat_gateway" "nat_gateway" {
  depends_on = [aws_internet_gateway.vpc_igw]

  count = var.enable_nat_gateway == "true" ? 1 : 0

  allocation_id = aws_eip.nat_eip.*.id[count.index]
  subnet_id     = aws_subnet.public.*.id[count.index]

  tags = {
    Name = "nat-${var.environment}-${aws_vpc.vpc.id}-${count.index}"
  }
}

######################################################
# Create route table for private subnets             #
# Route non-local traffic through the NAT gateway    #
# to the Internet                                    #
######################################################
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.private_azs_with_cidr)

  tags = merge(local.common_tags, map("Name", "private-route-${var.environment}-${aws_vpc.vpc.id}-${count.index}"))
}

resource "aws_route" "private_nat_gateway" {
  count = var.enable_nat_gateway == "true" ? length(var.private_azs_with_cidr) : 0

  route_table_id         = aws_route_table.private.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.enable_nat_gateway == "true" ? aws_nat_gateway.nat_gateway.*.id[0] : ""
}

resource "aws_route_table_association" "private_association" {
  count = length(var.private_azs_with_cidr)

  route_table_id = aws_route_table.private.*.id[count.index]
  subnet_id      = aws_subnet.private.*.id[count.index]
}


######################################################
# Route the public subnet traffic through            #
# the Internet Gateway                               #
######################################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = merge(local.common_tags, map("Name", "public-route-${var.environment}-${aws_vpc.vpc.id}"))
}

resource "aws_route_table_association" "public_association" {
  count = length(var.public_azs_with_cidr)

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public.*.id[count.index]
}


######################################################
# Public subnets                                     #
# Each subnet in a different AZ                      #
######################################################
resource "aws_subnet" "public" {
  count = length(var.public_azs_with_cidr)

  cidr_block              = values(var.public_azs_with_cidr)[count.index]
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = keys(var.public_azs_with_cidr)[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, map("Name", "publicSubnet-${var.environment}-${element(keys(var.public_azs_with_cidr), count.index)}"))
}


######################################################
# Private subnets                                    #
# Each subnet in a different AZ                      #
######################################################
resource "aws_subnet" "private" {
  count = length(var.private_azs_with_cidr)

  cidr_block              = values(var.private_azs_with_cidr)[count.index]
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = keys(var.private_azs_with_cidr)[count.index]
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, map("Name", "privateSubnet-${var.environment}-${element(keys(var.public_azs_with_cidr), count.index)}"))
}


######################################################
# Private DB subnets for RDS, Aurora                 #
# Each subnet in a different AZ                      #
######################################################
resource "aws_subnet" "db_subnets_private" {
  count = length(var.db_azs_with_cidr)

  cidr_block              = values(var.db_azs_with_cidr)[count.index]
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = keys(var.db_azs_with_cidr)[count.index]
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, map("Name", "db_subnet-${var.environment}-${element(keys(var.db_azs_with_cidr), count.index)}"))
}

