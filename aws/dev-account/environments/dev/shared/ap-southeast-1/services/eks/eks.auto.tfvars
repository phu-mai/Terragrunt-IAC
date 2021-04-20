
eks_cluster_name = "shared-eks-dev-001"
cluster_version  = "1.18"
enable_irsa      = true
workers_additional_policies = [
  "EC2EbsCsiDriver",
]
map_users = [
  {
    userarn  = "AWSReservedSSO_DEVOPS_8fe62e3e43fzxyas"
    username = "devops-team"
    groups   = ["system:masters"]
  }
]

worker_groups_launch_template = [
  {
    name                 = "on-demand-infra_ap-southeast-1a"
    key_name             = "<key_name>"
    instance_type        = "t3a.medium"
    asg_min_size         = 1
    asg_desired_capacity = 1
    asg_max_size         = 1
    availability_zone    = "ap-southeast-1a"
    bootstrap_extra_args    = "--enable-docker-bridge true --use-max-pods false"
    kubelet_extra_args   = "--node-labels=node.kubernetes.io/lifecycle=normal,daemonset=active,node=infra-ondemand --max-pods=220 --register-with-taints=infra=true:NoSchedule --eviction-hard imagefs.available<15% --feature-gates=CSINodeInfo=true,CSIDriverRegistry=true,CSIBlockVolume=true,ExpandInUsePersistentVolumes=true,ExpandCSIVolumes=true"
  },
  {
    name                 = "on-demand-infra_ap-southeast-1b"
    key_name             = "<key_name>"
    instance_type        = "t3a.medium"
    asg_min_size         = 1
    asg_desired_capacity = 1
    asg_max_size         = 1
    availability_zone    = "ap-southeast-1b"
    bootstrap_extra_args    = "--enable-docker-bridge true --use-max-pods false"
    kubelet_extra_args   = "--node-labels=node.kubernetes.io/lifecycle=normal,daemonset=active,node=infra-ondemand --max-pods=220 --register-with-taints=infra=true:NoSchedule --eviction-hard imagefs.available<15% --feature-gates=CSINodeInfo=true,CSIDriverRegistry=true,CSIBlockVolume=true,ExpandInUsePersistentVolumes=true,ExpandCSIVolumes=true"
  },
  {
    name                 = "on-demand-infra_ap-southeast-1c"
    key_name             = "<key_name>"
    instance_type        = "t3a.medium"
    asg_min_size         = 1
    asg_desired_capacity = 1
    asg_max_size         = 1
    availability_zone    = "ap-southeast-1c"
    bootstrap_extra_args    = "--enable-docker-bridge true --use-max-pods false"
    kubelet_extra_args   = "--node-labels=node.kubernetes.io/lifecycle=normal,daemonset=active,node=infra-ondemand --max-pods=220 --register-with-taints=infra=true:NoSchedule --eviction-hard imagefs.available<15% --feature-gates=CSINodeInfo=true,CSIDriverRegistry=true,CSIBlockVolume=true,ExpandInUsePersistentVolumes=true,ExpandCSIVolumes=true"
  },
  {
    name                    = "spot-general-0_ap-southeast-1a"
    key_name                = "<key_name>"
    override_instance_types = ["t3a.2xlarge", "t3.2xlarge", "m5a.2xlarge", "m5.2xlarge"]
    spot_instance_pools     = 4
    asg_min_size            = 1
    asg_desired_capacity    = 1
    asg_max_size            = 10
    availability_zone       = "ap-southeast-1a"
    bootstrap_extra_args    = "--enable-docker-bridge true --use-max-pods false"
    kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot,daemonset=active,app=general --max-pods=220 --eviction-hard imagefs.available<15% --feature-gates=CSINodeInfo=true,CSIDriverRegistry=true,CSIBlockVolume=true,ExpandInUsePersistentVolumes=true,ExpandCSIVolumes=true"
  },
  {
    name                    = "spot-general-0_ap-southeast-1b"
    key_name                = "<key_name>"
    override_instance_types = ["t3a.2xlarge", "t3.2xlarge", "m5a.2xlarge", "m5.2xlarge"]
    spot_instance_pools     = 4
    asg_min_size            = 1
    asg_desired_capacity    = 1
    asg_max_size            = 10
    availability_zone       = "ap-southeast-1b"
    bootstrap_extra_args    = "--enable-docker-bridge true --use-max-pods false"
    kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot,daemonset=active,app=general --max-pods=220 --eviction-hard imagefs.available<15% --feature-gates=CSINodeInfo=true,CSIDriverRegistry=true,CSIBlockVolume=true,ExpandInUsePersistentVolumes=true,ExpandCSIVolumes=true"
  },
  {
    name                    = "spot-general-0_ap-southeast-1c"
    key_name                = "<key_name>"
    override_instance_types = ["t3a.2xlarge", "t3.2xlarge", "m5a.2xlarge", "m5.2xlarge"]
    spot_instance_pools     = 4
    asg_min_size            = 1
    asg_desired_capacity    = 1
    asg_max_size            = 10
    availability_zone       = "ap-southeast-1c"
    bootstrap_extra_args    = "--enable-docker-bridge true --use-max-pods false"
    kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot,daemonset=active,app=general --max-pods=220 --eviction-hard imagefs.available<15% --feature-gates=CSINodeInfo=true,CSIDriverRegistry=true,CSIBlockVolume=true,ExpandInUsePersistentVolumes=true,ExpandCSIVolumes=true"
  },
  {
    name                 = "on-demand-shop-0"
    key_name             = "<key_name>"
    instance_type        = "t3a.large"
    asg_min_size         = 1
    asg_desired_capacity = 1
    asg_max_size         = 3
    availability_zone    = "ap-southeast-1a"
    bootstrap_extra_args    = "--enable-docker-bridge true --use-max-pods false"
    kubelet_extra_args   = "--node-labels=node.kubernetes.io/lifecycle=normal,daemonset=active,shop=active --max-pods=220 --register-with-taints=shop=true:NoSchedule --eviction-hard imagefs.available<15% --feature-gates=CSINodeInfo=true,CSIDriverRegistry=true,CSIBlockVolume=true,ExpandInUsePersistentVolumes=true,ExpandCSIVolumes=true"
  }
]
