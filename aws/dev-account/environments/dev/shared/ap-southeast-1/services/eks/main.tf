module "eks_cluster_001" {
  source          = "git::git@github.com:cxagroup/infra-terraform-base//eks-clusters"
  env_name        = var.env_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids
  account_id      = var.account_id
  cluster_name    = var.eks_cluster_name
  enable_irsa                   = var.enable_irsa
  workers_additional_policies   = [for policy in var.workers_additional_policies: "arn:aws:iam::${var.account_id}:policy/${policy}" ]
  worker_groups_launch_template = local.worker_groups_launch_template
  map_users       = local.map_users
  tags            = var.tags
}
