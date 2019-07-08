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
