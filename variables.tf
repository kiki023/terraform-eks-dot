variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  default = "dev3"
  type    = string
}

variable "cluster_version" {
  default = "1.27"
}

variable "vpc_id" {
  default = ""
  type = string
}

variable "subnet_ids" {
  default = ["", ""]
  
} 

variable "cluster_endpoint" {
  default = ""
}

variable "openid_connect_provider" {
  default = ""
}
