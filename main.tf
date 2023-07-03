provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}


resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                         = var.vpc_id
  subnet_ids                     = var.subnet_ids
  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true
  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }
  enable_irsa = true
  eks_managed_node_groups = {
    general = {
      name = "dev3-node"

      instance_types = ["m5.xlarge"]

      min_size     = 1
      max_size     = 6
      desired_size = 1

      labels = {
        role = "general"
      }
    }

    spot = {
      name = "dev3-spot-node"
      desired_size = 1
      min_size     = 1
      max_size     = 6

      labels = {
        role = "spot"
      }

      taints = [{
        key    = "dev3"
        value  = "spot"
        effect = "NO_SCHEDULE"
      }]

      instance_types = ["m5.xlarge"]
      capacity_type  = "SPOT"
    }
  
  }

  tags = {
    Environment = "dev3"
  }
}


 
