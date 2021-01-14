terraform {
  required_version = ">= 0.13.2"
}

provider "aws" {
  version = ">= 3.5.0"
  region  = "ap-southeast-2"
}

# inport network value
data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket         = "cicd-dev-tfstate"
    key            = "network/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "cicd-dev-tfstate-lock"
    region         = "ap-southeast-2"
  }
}

# common parameter settings
locals {
  pj       = "cicd-dev"
  app      = "test-app"
  app_full = "${local.pj}-${local.app}"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id
  tags     = {
    pj     = "cicd-dev"
    app    = "test-app"
    owner = "nobody"
  }
}

module "preparation" {
  source = "../../../modules/service/preparation"

  # common parameter
  tags   = local.tags
  vpc_id = local.vpc_id

  # module parameter
  ecr_repositories = [local.app_full]

  sg_name   = local.app_full
}
