################################ [ Output VPC ] ###############################
output "vpc_id" {
  value = module.aws_vpc_001.vpc_base.vpc_id
}

output "private_subnets_ids" {
  value = module.aws_vpc_001.vpc_base.private_subnets
}

output "public_subnets_ids" {
  value = module.aws_vpc_001.vpc_base.public_subnets
}

output "private_subnets_cidr_blocks" {
  value = module.aws_vpc_001.vpc_base.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  value = module.aws_vpc_001.vpc_base.public_subnets_cidr_blocks
}

output "azs_private_subnet_ids" {
  value = zipmap(
    module.aws_vpc_001.vpc_base.azs,
    coalescelist(slice(module.aws_vpc_001.vpc_base.private_subnets, 0, 3)),
  )
  description = "Map of AZ names to subnet IDs"
}

