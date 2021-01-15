output "repository_app" {
    value = aws_codecommit_repository.app.clone_repo_https
}

output "repository_ecs" {
    value = aws_codecommit_repository.ecs.clone_repo_https
}