terraform {

  backend "s3" {

    bucket = "dotpay-dev-demo"
    key    = "s3/terraform.tfstate"
    region = "us-west-1"

    # dynamodb_table = "dotpaydB"
    encrypt        = true

  }


  required_version = "~> 1.1" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">=3.20.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"

    }

    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.0.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.0.0"
    }

    template = {
      source  = "hashicorp/template"
      version = ">=2.0.1"
    }
  }
}


resource "aws_dynamodb_table" "terraform_statelock" {
  name           = var.aws_dynamodb_table
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
