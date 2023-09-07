terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  backend "s3" {
    # bucket name where to keep terraform state file
    bucket  = "terraform-poc-us-east-1"
    profile = "default"
    encrypt = "true"
    key     = "vault_ecs/state_main"
    region  = "us-east-1"
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "us-east-1"
}


# Fetch the existing VPC
data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Fetch the existing public subnets
data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.existing.id

  tags = {
    Tier = var.public_subnet_tier
  }
}

# Fetch the existing private subnets
data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.existing.id

  tags = {
    Tier = var.private_subnet_tier
  }
}
