variable "project_id" {
  type    = string
  default = "your-gcp-project-id" # ここは自分のプロジェクトIDに書き換え
}

variable "region" {
  type    = string
  default = "asia-northeast1"
}

variable "vpc_name" {
  type    = string
  default = "shared-vpc"
}