resource "aws_iam_role" "lambda-add-security-headers" {
  name               = "lambda-add-security-headers"
  assume_role_policy = data.aws_iam_policy_document.allow-edgelambda-to-assumerole.json
}

resource "aws_iam_role_policy_attachment" "lambda-add-security-headers-basic-execution-role" {
  role       = aws_iam_role.lambda-add-security-headers.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "lambda-add-security-headers-artifact" {
  type        = "zip"
  output_path = "lambda/security-headers.zip"
  source_file = "lambda/security-headers/index.js"
}

resource "aws_lambda_function" "cloudfront-add-security-headers" {
  function_name = "cloudfront-security-headers"
  description   = "redirects to/from index.html and trailing slashes and such"

  role             = aws_iam_role.lambda-add-security-headers.arn
  filename         = data.archive_file.lambda-add-security-headers-artifact.output_path
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda-add-security-headers-artifact.output_base64sha256
  runtime          = "nodejs8.10"
  publish          = true
  provider         = "aws.east"
}
