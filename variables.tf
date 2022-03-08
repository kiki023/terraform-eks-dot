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
variable "public_subnets_cidr" {
  default = ["10.20.1.0/24","10.20.2.0/24"]
}
variable "private_subnets_cidr"
  default = ["10.20.3.0/24", "10.20.4.0/24"]
}
