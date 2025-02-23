output "music-catalogue-table-ops-function-arn" {
  value = aws_lambda_function.music-catalogue-table-ops.arn
}

output "music-catalogue-table-ops-function-name" {
  value = aws_lambda_function.music-catalogue-table-ops.function_name
}

output "music-catalogue-users-function-arn" {
  value = aws_lambda_function.music-catalogue-users.arn
}

output "music-catalogue-users-function-name" {
  value = aws_lambda_function.music-catalogue-users.function_name
}