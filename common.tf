data "aws_iam_policy_document" "allow-edgelambda-to-assumerole" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com"
      ]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "allow-cloudwatch-writes" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

resource "aws_iam_policy" "allow-cloudwatch-writes" {
  name        = "allow-cloudwatch-writes"
  description = "allows writing to cloudwatch"

  policy = data.aws_iam_policy_document.allow-cloudwatch-writes.json

}