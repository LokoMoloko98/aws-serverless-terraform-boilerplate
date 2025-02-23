output "lambda-dynamodb-role-arn" {
  value = aws_iam_role.music-catalogue-lambda-role.arn
}

output "amplify-service-role-arn" {
  value = aws_iam_role.AmplifyConsoleServiceRole-AmplifyRole.arn
}