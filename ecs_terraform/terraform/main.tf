terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  backend "s3" {
    bucket  = "terraform-poc-us-east-1"
    profile = "default"
    encrypt = true
    key     = "vault-nginx-project/state_main"
    region  = "us-east-1"
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "us-east-1"
}

locals {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}
