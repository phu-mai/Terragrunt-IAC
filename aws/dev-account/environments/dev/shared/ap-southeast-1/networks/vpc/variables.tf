variable "env_name" {
  type = string
}
variable "region" {
  default = "ap-southeast-1"
}
variable "vpc_configs" {
  type = any
}
variable "vpc_name" {
  type = string
}
