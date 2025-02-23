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

# variable "swift_lift_club_cert_arn" {
#   type = string
# }

# variable "hosted_zone_id" {
#   type        = string 
# }

variable "amplify_app_id" {
  type        = string
}