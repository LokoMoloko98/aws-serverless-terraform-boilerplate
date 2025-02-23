resource "aws_cognito_user_pool" "music-catalogue-user_pool" {
  name = "${var.project_name}-user-pool"
  schema {
    name                     = "email"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = true
    developer_only_attribute = false
  }

  schema {
    name                     = "name"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = true
    developer_only_attribute = false
  }

  schema {
    name                     = "nickname"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = true
    developer_only_attribute = false

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_uppercase = true
  }

  username_attributes = ["email"]

  username_configuration {
    case_sensitive = false
  }

  admin_create_user_config {
    allow_admin_create_user_only = true
    invite_message_template {
      email_message = "Sign up detaile: username: {username} and temporary password: {####}."
      email_subject = "Welcome to  Swift Lift Club!"
      sms_message   = "Sign up details: username: {username} and temporary password: {####}."
    }
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
}

resource "aws_cognito_user_pool_client" "music-catalogue-user_pool_client" {
  user_pool_id                 = aws_cognito_user_pool.music-catalogue-user_pool.id
  name                         = "${var.project_name}-app-client"
  supported_identity_providers = ["COGNITO"]
  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",      # SRP Authentication
    "ALLOW_USER_PASSWORD_AUTH", # Username/Password flow
    "ALLOW_REFRESH_TOKEN_AUTH", # Refresh token flow
    "ALLOW_CUSTOM_AUTH"         # Custom authentication flow
  ]
  generate_secret                      = false
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = [
    "email",
    "openid",
    "profile"
  ]
  prevent_user_existence_errors = "ENABLED"
  refresh_token_validity        = 1
  access_token_validity         = 1
  id_token_validity             = 1
  token_validity_units {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "days"
  }

  callback_urls = [
    "https://${var.domain_name}/callback",
    "http://localhost:3000/callback" # For local testing
  ]

  logout_urls = [
    "https://${var.domain_name}/logout",
    "http://localhost:3000/logout"
  ]
}


resource "aws_ssm_parameter" "client_id" {
  name  = "/amplify/shared/${var.amplify_app_id}/NEXT_PUBLIC_COGNITO_CLIENT_ID"
  type  = "SecureString"
  value = aws_cognito_user_pool_client.music-catalogue-user_pool_client.id
}

resource "aws_ssm_parameter" "region" {
  name  = "/amplify/shared/${var.amplify_app_id}/NEXT_PUBLIC_AWS_REGION"
  type  = "SecureString"
  value = var.region
}

# resource "aws_cognito_user_pool_domain" "main" {
#   domain          = "auth-swift-lift-club.moloko-mokubedi.co.za"
#   certificate_arn = var.music-catalogue-cert_arn
#   user_pool_id    = aws_cognito_user_pool.music-catalogue-user_pool.id
# }

# resource "aws_route53_record" "auth-cognito-A-record" {
#   name    = aws_cognito_user_pool_domain.main.domain
#   type    = "A"
#   zone_id = var.hosted_zone_id
#   alias {
#     name                   = aws_cognito_user_pool_domain.main.cloudfront_distribution_arn
#     zone_id                = "Z2FDTNDATAQYW2" # CloudFront Zone ID
#     evaluate_target_health = false
#   }
# }
