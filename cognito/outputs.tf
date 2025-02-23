output "cognito_user_pool_arn" {
  value = aws_cognito_user_pool.music-catalogue-user_pool.arn
}

output "cognito_user_pool_client_name" {
  value = aws_cognito_user_pool_client.music-catalogue-user_pool_client.name
}

output "cognito_user_pool_endpoint" {
  value = aws_cognito_user_pool.music-catalogue-user_pool.endpoint
}

output "cognito_user_pool_client_id" {
  value = aws_cognito_user_pool.music-catalogue-user_pool.id
}