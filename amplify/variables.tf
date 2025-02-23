# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "lambda-role-arn" {
  type = string
}

variable "apigateway_arn" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "repository_url" {
  type = string
}

variable "amplify-service-role-arn" {
  type = string
}

variable "cognito_user_pool_client_id" {
  type = string
}