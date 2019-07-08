resource "aws_iam_role" "lambda-index-redirects" {
  name               = "lambda-index-redirects"
  assume_role_policy = data.aws_iam_policy_document.allow-edgelambda-to-assumerole.json
}

resource "aws_iam_role_policy_attachment" "lambda-index-redirects-allow-cloudwatch-writes" {
  role       = aws_iam_role.lambda-index-redirects.name
  policy_arn = aws_iam_policy.allow-cloudwatch-writes.arn
}