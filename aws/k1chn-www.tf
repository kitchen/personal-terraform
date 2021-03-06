resource "aws_s3_bucket" "k1chn-com" {
  bucket = "k1chn-com"
  acl    = "private"
}

data "aws_iam_policy_document" "s3-k1chn-com-allow-cloudfront" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.k1chn-com.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.k1chn-cloudfront.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.k1chn-com.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.k1chn-cloudfront.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "k1chn-com-allow-cloudfront" {
  bucket = aws_s3_bucket.k1chn-com.id
  policy = data.aws_iam_policy_document.s3-k1chn-com-allow-cloudfront.json
}

resource "aws_route53_record" "k1chn-com-a" {
  zone_id = aws_route53_zone.k1chn-com.zone_id
  name    = "."
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.k1chn-com.domain_name
    zone_id                = aws_cloudfront_distribution.k1chn-com.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "k1chn-com-aaaa" {
  zone_id = aws_route53_zone.k1chn-com.zone_id
  name    = "."
  type    = "AAAA"
  alias {
    name                   = aws_cloudfront_distribution.k1chn-com.domain_name
    zone_id                = aws_cloudfront_distribution.k1chn-com.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-k1chn-com-a" {
  zone_id = aws_route53_zone.k1chn-com.zone_id
  name    = "www"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.k1chn-com.domain_name
    zone_id                = aws_cloudfront_distribution.k1chn-com.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-k1chn-com-aaaa" {
  zone_id = aws_route53_zone.k1chn-com.zone_id
  name    = "www"
  type    = "AAAA"
  alias {
    name                   = aws_cloudfront_distribution.k1chn-com.domain_name
    zone_id                = aws_cloudfront_distribution.k1chn-com.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_acm_certificate" "k1chn-com" {
  domain_name               = "k1chn.com"
  subject_alternative_names = ["www.k1chn.com"]
  validation_method         = "DNS"
  provider                  = "aws.east"
}

resource "aws_route53_record" "k1chn-com-cert-validations" {
  for_each = {
    for dvo in aws_acm_certificate.k1chn-com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name    = each.value.name
  type    = each.value.type
  zone_id = aws_route53_zone.k1chn-com.zone_id
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "k1chn-com" {
  certificate_arn         = aws_acm_certificate.k1chn-com.arn
  validation_record_fqdns = [aws_route53_record.k1chn-com-cert-validation.fqdn, aws_route53_record.www-k1chn-com-cert-validation.fqdn]
  provider                = "aws.east"
}

resource "aws_cloudfront_origin_access_identity" "k1chn-cloudfront" {
  comment = "k1chn.com cloudfront origin access identity"
}

resource "aws_cloudfront_distribution" "k1chn-com" {
  origin {
    domain_name = aws_s3_bucket.k1chn-com.bucket_regional_domain_name
    origin_id   = "k1chn-com-origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.k1chn-cloudfront.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "k1chn.com cloudfront distribution"
  default_root_object = "index.html"

  aliases = ["k1chn.com", "www.k1chn.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "k1chn-com-origin"

    compress = true
    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"

    lambda_function_association {
      event_type = "origin-response"
      lambda_arn = aws_lambda_function.cloudfront-add-security-headers.qualified_arn
    }

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = aws_lambda_function.cloudfront-index-redirects.qualified_arn
    }

    min_ttl     = 0
    max_ttl     = 30
    default_ttl = 30
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  logging_config {
    bucket = "kitchen-logs-bucket.s3.amazonaws.com"
    prefix = "k1chn.com"
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.k1chn-com.arn
    ssl_support_method  = "sni-only"
  }

  # cloudfront takes *forever* to fully deploy
  wait_for_deployment = false
  depends_on          = [aws_acm_certificate_validation.k1chn-com]
}
