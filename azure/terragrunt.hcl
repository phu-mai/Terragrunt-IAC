locals {
  bucket_name   = "terragrunt-terraform-remote-state"
  bucket_region = "ap-southeast-1"

  # AWS account IDs
  aws_accounts   = {
    dev-account  = "28558478xyzx"
    prod-account = "28558478zzzz"
  }
}
