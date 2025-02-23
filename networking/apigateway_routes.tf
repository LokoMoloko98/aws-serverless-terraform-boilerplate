resource "aws_apigatewayv2_route" "user-profile" {
  api_id             = aws_apigatewayv2_api.music-catalogue-api-gateway.id
  route_key          = "GET /get-user"
  target             = "integrations/${aws_apigatewayv2_integration.music-catalogue-users-apigateway-lambda-integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.music-catalogue-api-gateway-authorizer.id
}

resource "aws_apigatewayv2_route" "add-to-music-catalogue" {
  api_id             = aws_apigatewayv2_api.music-catalogue-api-gateway.id
  route_key          = "PUT /music/add"
  target             = "integrations/${aws_apigatewayv2_integration.music-catalogue-table-ops-apigateway-lambda-integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.music-catalogue-api-gateway-authorizer.id
}

resource "aws_apigatewayv2_route" "update-music-catalogue" {
  api_id             = aws_apigatewayv2_api.music-catalogue-api-gateway.id
  route_key          = "PUT /music/update"
  target             = "integrations/${aws_apigatewayv2_integration.music-catalogue-table-ops-apigateway-lambda-integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.music-catalogue-api-gateway-authorizer.id
}

resource "aws_apigatewayv2_route" "get-music-catalogue" {
  api_id             = aws_apigatewayv2_api.music-catalogue-api-gateway.id
  route_key          = "GET /music/get-music"
  target             = "integrations/${aws_apigatewayv2_integration.music-catalogue-table-ops-apigateway-lambda-integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.music-catalogue-api-gateway-authorizer.id
}

resource "aws_apigatewayv2_route" "delete-music-catalogue-song" {
  api_id             = aws_apigatewayv2_api.music-catalogue-api-gateway.id
  route_key          = "DELETE /music/delete-music"
  target             = "integrations/${aws_apigatewayv2_integration.music-catalogue-table-ops-apigateway-lambda-integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.music-catalogue-api-gateway-authorizer.id
}