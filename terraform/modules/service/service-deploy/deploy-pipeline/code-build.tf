resource "aws_codebuild_project" "this" {
  name          = "${var.app_full}-build"
  build_timeout = "10"
  service_role  = var.codebuild_build_role_arn
  
  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.build_cache_store.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.codebuild_build_log_group_name
      stream_name = var.codebuild_build_log_stream_name
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  source_version = "master"
}
