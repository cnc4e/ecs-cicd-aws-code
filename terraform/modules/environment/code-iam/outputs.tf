output "deploy_role_arn" {
  value = aws_iam_role.codedeploy.arn
}

output "pipeline_role_arn" {
  value = aws_iam_role.codepipeline.arn
}
