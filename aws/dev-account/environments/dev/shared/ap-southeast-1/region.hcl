locals {
  region = "ap-southeast-1"
  # Automatically load account-level variables
  common_vars  = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  env_vars     = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl"))

  # Extract the variables we need for easy access
  role_name     = local.account_vars.locals.role_name
  bucket_name   = local.common_vars.locals.bucket_name
  bucket_region = local.common_vars.locals.bucket_region
  account_id    = local.account_vars.locals.account_id

  project        = local.project_vars.locals.project
  env            = local.env_vars.locals.env
  iam_arn        = "arn:aws:iam::${local.account_id}"
  project_prefix = "${local.project}-${local.env}"

}
