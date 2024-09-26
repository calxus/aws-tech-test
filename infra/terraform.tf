terraform {
  required_version = "1.9.6"
/*
  backend "s3" {
    bucket         = "calxus-aws-tech-test"
    key            = "calxus-aws-tech-test.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state"
  }
*/
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.16.0"
    }
    aws = {
      version = "~> 5.68.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ecr_authorization_token" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

provider "docker" {
  registry_auth {
    address  = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com"
    username = "AWS"
    password = data.aws_ecr_authorization_token.current.password
  }
}

locals {
  availability_zones = 3
}