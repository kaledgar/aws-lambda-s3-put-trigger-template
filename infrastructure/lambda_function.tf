#resource "aws_lambda_function" "trigger" {
#  function_name = "${local.project_prefix}-lambda"
#  description = "I get triggered by file from s3"
#  runtime = "python3.9"
#  handler = "trigger.lambda_handler"
# }

resource "aws_iam_role" "lambda_role" {
  name = "${local.project_prefix}-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
