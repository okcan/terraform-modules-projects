resource "aws_lambda_function" "my_lambda" {
  function_name = "my-lambda-function"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  source_code_hash = filebase64("${path.module}/lambda.zip")
}

