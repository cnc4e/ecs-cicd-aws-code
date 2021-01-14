terraform {
  required_version = ">= 0.13.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.13.0"
    }
  }

  backend "s3" {
    bucket         = "cicd-dev-tfstate"
    key            = "test-app-preparation/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "cicd-dev-tfstate-lock"
    region         = "ap-southeast-2"
  }
}