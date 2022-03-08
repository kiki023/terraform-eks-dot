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
  default = "t3.large"
}

variable "aws_dynamodb_table" {
  default = "dotpaydB"
}
