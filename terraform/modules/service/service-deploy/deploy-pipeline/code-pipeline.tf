locals {
  setting_artifacts_name = "settings"
  app_artifacts_name   = "app"
  image_artifacts_name   = "images"
}

resource "aws_codepipeline" "this" {
  name     = "${var.app_full}-pipeline"
  role_arn = var.codepipeline_pipeline_role_arn
  tags = merge(
    {
      "Name" = "${var.app_full}-pipeline"
    },
    var.tags
  )

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.artifact_store.bucket
  }

  stage {
    name = "Source"
    
    action {
      name             = "CodeDeploySettings"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = [local.setting_artifacts_name]
      run_order        = 1

      configuration = {
        RepositoryName = "${var.app_full}-ecs"
        BranchName = "master"
      }
    }
    
    action {
      name             = "App"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = [local.app_artifacts_name]
      run_order        = 1

      configuration = {
        RepositoryName = "${var.app_full}-app"
        BranchName = "master"
      }
    }
  }
  
  stage {
    name = "Build"

    action {
      name = "Build"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      version = "1"
      input_artifacts = [local.app_artifacts_name]
      output_artifacts = [local.image_artifacts_name]
      
      configuration = {
        ProjectName = "${var.app_full}-build"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      version         = "1"
      input_artifacts = [local.setting_artifacts_name, local.image_artifacts_name]

      configuration = {
        ApplicationName                = aws_codedeploy_app.this.name
        DeploymentGroupName            = var.codedeploy_deployment_group_name
        TaskDefinitionTemplateArtifact = local.setting_artifacts_name
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = local.setting_artifacts_name
        AppSpecTemplatePath            = "appspec.yaml"
        Image1ArtifactName             = local.image_artifacts_name
        Image1ContainerName            = "IMAGE1_NAME"
      }
    }
  }

  depends_on = [aws_codedeploy_deployment_group.ecs]
}
