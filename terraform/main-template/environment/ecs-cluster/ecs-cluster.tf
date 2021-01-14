terraform {
  required_version = ">= 0.13.2"
}

provider "aws" {
  version = ">= 3.5.0"
  region  = "ap-southeast-2"
}

# common parameter settings
locals {
  pj   = "cicd-dev"
  tags = {
    pj     = "cicd-dev"
    owner = "nobody"
  }
}

module "gitlab-ecs-cicd-ecs-cluster" {
  source = "../../../modules/environment/ecs-cluster"

  # common parameter
  pj   = local.pj
  tags = local.tags

  # module parameter
  cluster_name = "${local.pj}-cluster"
}

module "code-iam" {
  source = "../../../modules/environment/code-iam"

  # common parameter
  pj   = local.pj
}
