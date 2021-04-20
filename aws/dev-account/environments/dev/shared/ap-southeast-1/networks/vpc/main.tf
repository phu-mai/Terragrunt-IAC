module "aws_vpc_001" {
  source = "git@github.com:phu-mai/hcl-abstraction-vpc.git"
  name   = var.vpc_name
  vpc_configs  = var.vpc_configs
  tags   = {
    Environment = var.env_name
  }
}
