# common parameter
variable "app_full" {
  description = "リソース群に付与する名前の接頭語。プロジェクト名-アプリケーション名。"
  type        = string
}

variable "vpc_id" {
  description = "リソース群が属するVPCのID"
  type        = string
}

variable "tags" {
  description = "リソース群に付与する共通タグ"
  type        = map(string)
}

# module parameter
# code-build.tf
variable "codebuild_build_role_arn" {
  description = "ビルドプロジェクトに与えるIAMロール"
  type        = string
}

variable "codebuild_build_log_group_name" {
  description = "ビルドプロジェクトのログを取得するCloudWatchのグループ名"
  type        = string
}

variable "codebuild_build_log_stream_name" {
  description = "ビルドプロジェクトのログを取得するCloudWatchのストリーム名"
  type        = string
}

# code-deploy.tf
variable "codedeploy_deployment_group_name" {
  description = "デプロイグループの名前"
  type        = string
}

variable "codedeploy_service_role_arn" {
  description = "デプロイグループに与えるIAMロール"
  type        = string
}

variable "codedeploy_ecs_cluster_name" {
  description = "デプロイする対象のECSクラスタ名"
  type        = string
}

variable "codedeploy_ecs_service_name" {
  description = "デプロイする対象のECSサービス名"
  type        = string
}

variable "codedeploy_prod_listener_arn" {
  description = "デプロイに使用するLBのARN"
  type        = string
}

variable "codedeploy_blue_target_group_name" {
  description = "現行バージョンのターゲットグループ"
  type        = string
}

variable "codedeploy_green_target_group_name" {
  description = "新バージョンのターゲットグループ"
  type        = string
}

variable "codedeploy_termination_wait_time_in_minutes" {
  description = "現行バージョンのタスクを削除するまでの待ち時間"
  type        = number
}

# s3.tf
variable "s3_artifact_store_name" {
  description = "codepipelineが使用するアーティファクトストアのバケット名"
  type        = string
}

variable "s3_build_cache_store_name" {
  description = "codebuildが使用するビルドのキャッシュストアのバケット名"
  type        = string
}

# code-pipeline.tf
variable "codepipeline_ecr_repository_name" {
  description = "変更を検知してデプロイする対象のECRレポジトリ名"
  type        = string
}

variable "codepipeline_pipeline_role_arn" {
  description = "CodePipelineからCodeDeployを実行するIAMロール"
  type        = string
}

