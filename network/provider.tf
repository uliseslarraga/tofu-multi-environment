terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket                = "tf-backend-ulr-2025-05-04"
    key                   = "network/terraform.tfstate"
    region                = "us-east-1"
    workspace_key_prefix  = "environment"
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}