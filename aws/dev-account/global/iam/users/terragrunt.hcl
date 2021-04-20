include {
  path = find_in_parent_folders()
}

locals {
  # Automatically load account-level variables
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  common_vars  = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))

  # Extract the variables we need for easy access
  region        = local.region_vars.locals.region
  account_id    = local.account_vars.locals.account_id
  role_name     = local.account_vars.locals.role_name
  bucket_name   = local.common_vars.locals.bucket_name
  bucket_region = local.common_vars.locals.bucket_region
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/${get_env("ROLE_NAME","${local.role_name}")}"
  }
  region     = "${get_env("region","${local.region}")}"
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
    bucket = "${local.bucket_name}"
    key = "aws/${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.bucket_region}"
    encrypt        = true
  }
}
