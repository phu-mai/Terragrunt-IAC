locals {
  eks_worker_groups_launch_template = {
    for k, v in var.worker_groups_launch_template : k => merge(
      {
        subnets = length(lookup(v, "availability_zone", "")) ==  0 ? var.subnet_ids : [var.azs_private_subnet_ids[lookup(v, "availability_zone")]]
      },
      v,
    )
  }
  eks_map_users = {
    for k, v in var.map_users : k => merge(
      {
        userarn  = length(regexall("^arn:aws:iam::", lookup(v, "userarn"))) == 0 ?  "arn:aws:iam::${var.account_id}:role/${lookup(v, "userarn")}" : lookup(v, "userarn")
        username = lookup(v, "username")
        groups   = lookup(v, "groups")
      },
    )
  }
  worker_groups_launch_template = [for k, v in local.eks_worker_groups_launch_template : v]
  map_users = [for k, v in local.eks_map_users : v]
}
