output "apigateway_arn" {
  value = aws_apigatewayv2_api.music-catalogue-api-gateway.execution_arn
}

output "apigateway_id" {
  value = aws_apigatewayv2_api.music-catalogue-api-gateway.id
}
