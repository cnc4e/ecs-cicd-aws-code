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

# ecr.tf
variable "ecr_repositories" {
  description = "作成するECRリポジトリ名のリスト"
  type        = list(string)
}

# sg.tf
variable "sg_name" {
  description = "ECS Serviceに付与するSGの名前"
  type        = string
}
