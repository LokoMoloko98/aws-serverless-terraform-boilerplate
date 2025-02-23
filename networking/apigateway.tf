resource "aws_apigatewayv2_api" "music-catalogue-api-gateway" {
  name          = "${var.project_name}-http-api"
  description   = "music-catalogue API_gateway"
  protocol_type = "HTTP"
  #Allowing cors configuration (very important)
  cors_configuration {
    allow_credentials = true
    allow_headers     = ["Authorization", "Content-Type", "X-Amz-Date", "X-Api-Key", "X-Amz-Security-Token"]
    allow_methods     = ["GET", "POST", "PUT", "OPTIONS"]
    allow_origins     = ["http://localhost:3000", "https://${var.domain_name}"]
    expose_headers    = ["Authorization"]
    max_age           = 300
  }
}

# Integrations with the Lambda functions created in the previous step
resource "aws_apigatewayv2_integration" "music-catalogue-table-ops-apigateway-lambda-integration" {
  api_id               = aws_apigatewayv2_api.music-catalogue-api-gateway.id
  integration_type     = "AWS_PROXY"
  connection_type      = "INTERNET"
  description          = "music-catalogue-table-ops lambda function integration"
  integration_uri      = var.music-catalogue-table-ops-function-arn
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_integration" "music-catalogue-users-apigateway-lambda-integration" {
  api_id               = aws_apigatewayv2_api.music-catalogue-api-gateway.id
  integration_type     = "AWS_PROXY"
  connection_type      = "INTERNET"
  description          = "music-catalogue lambda function integration"
  integration_uri      = var.music-catalogue-users-function-arn
  passthrough_behavior = "WHEN_NO_MATCH"
}

# API staging, cloudwatch logging and deployment set up 
resource "aws_apigatewayv2_stage" "music-catalogue-api-gateway-production-stage" {
  api_id        = aws_apigatewayv2_api.music-catalogue-api-gateway.id
  name          = "v1"
  deployment_id = aws_apigatewayv2_deployment.music-catalogue-apigateway-prd-deployment.id

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.main_api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

# Deployment of the API and attaching routes
resource "aws_apigatewayv2_deployment" "music-catalogue-apigateway-prd-deployment" {
  api_id      = aws_apigatewayv2_api.music-catalogue-api-gateway.id
  description = "music-catalogue deployment policy"

  triggers = {
    redeployment = sha1(join(",", tolist([
      jsonencode(aws_apigatewayv2_integration.music-catalogue-table-ops-apigateway-lambda-integration),
      jsonencode(aws_apigatewayv2_integration.music-catalogue-users-apigateway-lambda-integration),
      jsonencode(aws_apigatewayv2_route.user-profile),
      jsonencode(aws_apigatewayv2_route.add-to-music-catalogue),
      jsonencode(aws_apigatewayv2_route.update-music-catalogue),
      jsonencode(aws_apigatewayv2_route.get-music-catalogue),
      jsonencode(aws_apigatewayv2_route.delete-music-catalogue-song)
    ])))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "main_api_gw" {
  name = "/aws/api-gw/${aws_apigatewayv2_api.music-catalogue-api-gateway.name}"

  retention_in_days = 30
}

# Authorizer for the API Gateway routes, auth issued by cognito user pool
resource "aws_apigatewayv2_authorizer" "music-catalogue_authorizer" {
  api_id           = aws_apigatewayv2_api.music-catalogue-api-gateway.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "music-catalogue-cognito-authorizer"

  jwt_configuration {
    audience = ["${var.cognito_user_pool_client_id}"]
    issuer   = "https://${var.cognito_user_pool_endpoint}"
  }
}
