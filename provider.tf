terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  assume_role {
    role_arn = var.aws_assume_role_arn
  }

  region = var.aws_region


  default_tags {
    tags = {
      Team = "lenderservices",
      App  = "consumerduty",
      Env  = var.stage
    }
  }
}
