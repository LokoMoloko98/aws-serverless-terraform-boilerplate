output "apigateway_arn" {
  value = aws_apigatewayv2_api.music-catalogue-api-gateway.execution_arn
}

output "apigateway_id" {
  value = aws_apigatewayv2_api.music-catalogue-api-gateway.id
  
}

# output "swift_lift_club_cert_arn" {
#   value = aws_acm_certificate.swift-lift-club-cert.arn
# }