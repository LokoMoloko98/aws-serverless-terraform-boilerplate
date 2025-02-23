output "users-dynamodb-table-arn" {
  value = aws_dynamodb_table.users-dynamodb-table.arn
}

output "users-dynamodb-table-name" {
  value = aws_dynamodb_table.users-dynamodb-table.name
}

output "trips-dynamodb-table-name" {
  value = aws_dynamodb_table.music-catalogue-dynamodb-table.name
}

output "trips-dynamodb-table-arn" {
  value = aws_dynamodb_table.music-catalogue-dynamodb-table.arn
}