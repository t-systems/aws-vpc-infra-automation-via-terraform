output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "private_cidrs" {
  value = module.vpc.private_cidrs
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "public_cidrs" {
  value = module.vpc.public_cidrs
}

output "db_subnets" {
  value = module.vpc.db_subnets
}

output "db_cidrs" {
  value = module.vpc.db_cidrs
}

output "private_rt" {
  value = module.vpc.private_rt
}

output "public_rt" {
  value = module.vpc.public_rt
}


output "bastion_sg" {
  value = module.vpc.bastion_sg_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr_block
}
