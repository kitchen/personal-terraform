resource "aws_iam_role" "lambda-index-redirects" {
  name               = "lambda-index-redirects"
  assume_role_policy = data.aws_iam_policy_document.allow-edgelambda-to-assumerole.json
}

resource "aws_iam_role_policy_attachment" "lambda-index-redirects-basic-execution-role" {
  role       = aws_iam_role.lambda-index-redirects.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "lambda-index-redirects-artifact" {
  type        = "zip"
  output_path = "lambda/cloudfront-index-redirects.zip"
  source_file = "lambda/cloudfront-index-redirects/index.js"
}

resource "aws_lambda_function" "cloudfront-index-redirects" {
  function_name = "cloudfront-index-redirects"
  description   = "redirects to/from index.html and trailing slashes and such"

  role             = aws_iam_role.lambda-index-redirects.arn
  filename         = data.archive_file.lambda-index-redirects-artifact.output_path
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda-index-redirects-artifact.output_base64sha256
  runtime          = "nodejs8.10"
  publish          = true
  provider         = "aws.east"
}
