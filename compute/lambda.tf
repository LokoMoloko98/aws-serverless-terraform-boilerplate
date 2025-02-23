resource "aws_lambda_function" "music-catalogue-table-ops" {
  s3_bucket     = "mea-munera-lambda"                                             # The bucket where the lambda code is stored
  s3_key        = "music-catalogue-table-ops/music-catalogue-table-ops-1.0.1.zip" # The key of the object in the bucket
  function_name = "music-catalogue-table-ops"                                     # The name of the lambda function
  role          = var.lambda-role-arn                                             # The ARN of the role that the lambda function will assume
  handler       = "music-catalogue-table-ops.lambda_handler"                      # The name of the handler function
  timeout       = 90                                                              # The maximum amount of time that the lambda function can run
  runtime       = "python3.12"                                                    # The runtime that the lambda function will use

  environment {
    variables = {
      Name        = "${var.project_name}-music-catalogue-table-ops"
      Environment = "production"
      Costs       = "${var.project_name}"
    }
  }
}

resource "aws_lambda_function" "music-catalogue-users" {
  s3_bucket     = "mea-munera-lambda"                                     # The bucket where the lambda code is stored
  s3_key        = "music-catalogue-users/music-catalogue-users-1.0.1.zip" # The key of the object in the bucket
  function_name = "music-catalogue-users"                                 # The name of the lambda function
  role          = var.lambda-role-arn                                     # The ARN of the role that the lambda function will assume
  handler       = "music-catalogue-users.lambda_handler"                  # The name of the handler function
  timeout       = 90                                                      # The maximum amount of time that the lambda function can run
  runtime       = "python3.12"                                            # The runtime that the lambda function will use

  environment {
    variables = {
      Name        = "${var.project_name}-music-catalogue-users"
      Environment = "production"
      Costs       = "${var.project_name}"
    }
  }
}
