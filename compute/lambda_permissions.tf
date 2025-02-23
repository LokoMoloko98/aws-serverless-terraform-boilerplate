resource "aws_lambda_permission" "lambda_apigateway_permission_music-catalogue-table-ops" {
  statement_id  = "apigateway-invoke-permissions"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.music-catalogue-table-ops.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.apigateway_arn}/*/*/*"
}

resource "aws_lambda_permission" "lambda_apigateway_permission_music-catalogue-users" {
  statement_id  = "apigateway-invoke-permissions"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.music-catalogue-users.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.apigateway_arn}/*/*/*"
}