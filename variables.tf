# Variables Configuration
#

variable "cluster-name" {
  default = "dotpay-dev-demo"
  type    = string
}
variable "key_pair_name" {
  default = "dev-demo"
}
variable "eks_node_instance_type" {
  default = "m4.large"
}

variable "aws_dynamodb_table" {
  default = "dotpaydB"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}
