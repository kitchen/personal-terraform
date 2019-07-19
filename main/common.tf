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

locals {
  s3_alias_target  = "s3-website-us-west-2.amazonaws.com"
  s3_alias_zone_id = "Z3BJ6K6RIION7M"
}