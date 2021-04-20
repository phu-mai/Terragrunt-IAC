module "aws_vpc_001" {
  source = "https://github.com/phu-mai/vpc"
  name   = var.vpc_name
  vpc_configs  = var.vpc_configs
  tags   = {
    Environment = var.env_name
  }
}
