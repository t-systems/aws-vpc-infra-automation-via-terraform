output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "public_cidrs" {
  value = aws_subnet.public.*.cidr_block
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "private_cirds" {
  value = aws_subnet.private.*.cidr_block
}

output "db_subnets" {
  value = aws_subnet.db_subnets_private.*.id
}

output "db_cirds" {
  value = aws_subnet.db_subnets_private.*.cidr_block
}

output "private_rt" {
  value = aws_route_table.private.*.id
}

output "public_rt" {
  value = aws_route_table.public.*.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_host_sg.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "vpc_main_rt" {
  value = aws_route_table.vpc_main_rt.id
}

