include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../../networks/vpc"]
}

dependency "vpc" {
  config_path = "../../networks/vpc"

  mock_outputs_allowed_terraform_commands = ["validate","plan","show"]
  mock_outputs = {
    vpc_id = "vpc-77777777777777777"
    private_subnets_ids = [
      "subnet-11111111111111168",
      "subnet-22222222222222211",
      "subnet-33333333333333333",
      "subnet-44444444444444444",
      "subnet-55555555555555555",
      "subnet-66666666666666666",
    ]
    azs_private_subnet_ids = {
      "ap-southeast-1a" = "subnet-11111111111111168"
      "ap-southeast-1b" = "subnet-22222222222222211"
      "ap-southeast-1c" = "subnet-55555555555555555"
    }
  }
}

locals {

  # Automatically load account-level variables
  common_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract the variables we need for easy access
  account_id    = local.common_vars.locals.account_id
  role_name     = local.common_vars.locals.role_name
  bucket_name   = local.common_vars.locals.bucket_name
  bucket_region = local.common_vars.locals.bucket_region
  region        = local.common_vars.locals.region
  project       = local.common_vars.locals.project

  env           = local.common_vars.locals.env
  env_name      = "${local.project}-${local.env}"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/${get_env("ROLE_NAME", "${local.role_name}")}"
  }
  region     = "${get_env("region", "${local.region}")}"
}
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket  = "${local.bucket_name}"
    key     = "aws/${path_relative_to_include()}/terraform.tfstate"
    region  = "${local.bucket_region}"
    encrypt = true
  }
}

terraform {
  source = "."
}

inputs = {
  vpc_id                  = dependency.vpc.outputs.vpc_id
  subnet_ids              = dependency.vpc.outputs.private_subnets_ids
  azs_private_subnet_ids  = dependency.vpc.outputs.azs_private_subnet_ids
  account_id              = "${local.account_id}"
  env_name                = "${local.env_name}"
}
