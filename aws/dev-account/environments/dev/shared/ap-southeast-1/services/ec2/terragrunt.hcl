include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../../networks/vpc"

  mock_outputs_allowed_terraform_commands = ["validate","plan","show"]
  mock_outputs = {
    vpc_id = "vpc-0e964d8f7769zzzzz"
    private_subnets_ids = [
      "subnet-0d6c51e77e90yyyyy",
      "subnet-0f6dda78f436yyyyy",
      "subnet-08160966e5a2yyyyy",
      "subnet-05d1994b047dyyyyy",
      "subnet-00f877266113yyyyy",
      "subnet-077a10b6e044yyyyy",
    ]

    azs_private_subnet_ids = {
      "ap-southeast-1a" = "subnet-06f7b27f59ebxxxxx"
      "ap-southeast-1b" = "subnet-0664e7510991xxxxx"
      "ap-southeast-1c" = "subnet-0d68292707ddxxxxx"
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
    bucket  = local.bucket_name
    key     = "aws/${path_relative_to_include()}/terraform.tfstate"
    region  = local.bucket_region
    encrypt = true
  }
}

terraform {
  source = "."
}

inputs = {
  env_name = local.env_name
  key_name = "infra-${local.env_name}"
}
