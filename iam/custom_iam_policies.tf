resource "aws_iam_role_policy" "dynamodb-lambda-policy" {
  name = "${var.project_name}-dynamodb-lambdapolicy"
  role = aws_iam_role.music-catalogue-lambda-role.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : ["dynamodb:*"],
        "Resource" : ["${var.music-catalogue-users-function-arn}", "${var.music-catalogue-table-ops-function-arn}"]
      }
    ]
  })
}