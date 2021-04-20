variable "account_id" {
  type = string
}
variable "env_name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type  = list(string)
}
variable "azs_private_subnet_ids" {
  type = map(any)
}
variable "cluster_version" {
  type = string
}
variable "workers_additional_policies" {
  type = list(string)
}
variable "worker_groups_launch_template" {
  type = any
}
variable "map_users" {
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
}
variable "eks_cluster_name" {
  type = string
}
variable "bootstrap_extra_args" {
  default = "--enable-docker-bridge true"
}
variable "tags" {
  type = map(any)
  default = {}
}
variable "enable_irsa" {
  type = bool
  default = false
}
