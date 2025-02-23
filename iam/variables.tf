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


variable "apigateway_id" {
  type = string
}