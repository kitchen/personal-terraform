resource "aws_route53_record" "dev-k1chn-com-a" {
  zone_id = aws_route53_zone.k1chn-com.zone_id
  name    = "dev"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.dev-k1chn-com.domain_name
    zone_id                = aws_cloudfront_distribution.dev-k1chn-com.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-dev-k1chn-com-a" {
  zone_id = aws_route53_zone.k1chn-com.zone_id
  name    = "www.dev"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.dev-k1chn-com.domain_name
    zone_id                = aws_cloudfront_distribution.dev-k1chn-com.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_acm_certificate" "dev-k1chn-com" {
  domain_name               = "dev.k1chn.com"
  subject_alternative_names = ["www.dev.k1chn.com"]
  validation_method         = "DNS"
  provider                  = "aws.east"
}

resource "aws_route53_record" "dev-k1chn-com-cert-validation" {
  name    = aws_acm_certificate.dev-k1chn-com.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.dev-k1chn-com.domain_validation_options.0.resource_record_type
  zone_id = aws_route53_zone.k1chn-com.zone_id
  records = [aws_acm_certificate.dev-k1chn-com.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

resource "aws_route53_record" "www-dev-k1chn-com-cert-validation" {
  name    = aws_acm_certificate.dev-k1chn-com.domain_validation_options.1.resource_record_name
  type    = aws_acm_certificate.dev-k1chn-com.domain_validation_options.1.resource_record_type
  zone_id = aws_route53_zone.k1chn-com.zone_id
  records = [aws_acm_certificate.dev-k1chn-com.domain_validation_options.1.resource_record_value]
  ttl     = 60
}


resource "aws_acm_certificate_validation" "dev-k1chn-com" {
  certificate_arn         = aws_acm_certificate.dev-k1chn-com.arn
  validation_record_fqdns = [aws_route53_record.dev-k1chn-com-cert-validation.fqdn, aws_route53_record.www-dev-k1chn-com-cert-validation.fqdn]
  provider                = "aws.east"
}

resource "aws_cloudfront_distribution" "dev-k1chn-com" {
  origin {
    domain_name = aws_s3_bucket.k1chn-com.bucket_regional_domain_name
    origin_id   = "dev-k1chn-com-origin"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "dev.k1chn.com cloudfront distribution"
  default_root_object = "index.html"

  aliases = ["dev.k1chn.com", "www.dev.k1chn.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "dev-k1chn-com-origin"

    compress = true
    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"

    # lambda_function_association {
    #   event_type = "origin-request"
    #   lambda_arn = aws_lambda_function.cloudfront-index-redirects.qualified_arn
    # }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # logging_config {
  #   bucket = 
  # }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.dev-k1chn-com.arn
    ssl_support_method  = "sni-only"
  }



  depends_on = [aws_acm_certificate_validation.dev-k1chn-com]
}