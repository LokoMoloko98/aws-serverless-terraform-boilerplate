# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "music-catalogue-users-function-arn" {
  type = string
}

variable "music-catalogue-table-ops-function-arn" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "cognito_user_pool_client_id" {
  type = string
}

variable "cognito_user_pool_endpoint" {
  type = string
}