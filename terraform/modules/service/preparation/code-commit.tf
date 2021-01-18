resource "aws_codecommit_repository" "app" {
  repository_name = "${var.app_full}-app"
}

resource "aws_codecommit_repository" "ecs" {
  repository_name = "${var.app_full}-ecs"
}