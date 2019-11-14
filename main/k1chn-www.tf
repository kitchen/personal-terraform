resource "aws_s3_bucket" "k1chn-com" {
  bucket = "k1chn-com"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }
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

resource "aws_route53_record" "k1chn-com-cert-validation" {
  name    = aws_acm_certificate.k1chn-com.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.k1chn-com.domain_validation_options.0.resource_record_type
  zone_id = aws_route53_zone.k1chn-com.zone_id
  records = [aws_acm_certificate.k1chn-com.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

resource "aws_route53_record" "www-k1chn-com-cert-validation" {
  name    = aws_acm_certificate.k1chn-com.domain_validation_options.1.resource_record_name
  type    = aws_acm_certificate.k1chn-com.domain_validation_options.1.resource_record_type
  zone_id = aws_route53_zone.k1chn-com.zone_id
  records = [aws_acm_certificate.k1chn-com.domain_validation_options.1.resource_record_value]
  ttl     = 60
}


resource "aws_acm_certificate_validation" "k1chn-com" {
  certificate_arn         = aws_acm_certificate.k1chn-com.arn
  validation_record_fqdns = [aws_route53_record.k1chn-com-cert-validation.fqdn, aws_route53_record.www-k1chn-com-cert-validation.fqdn]
  provider                = "aws.east"
}

resource "aws_cloudfront_distribution" "k1chn-com" {
  origin {
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
    domain_name = aws_s3_bucket.k1chn-com.website_endpoint
    origin_id   = "k1chn-com-origin"
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
    min_ttl                = 0
    max_ttl                = 30
    default_ttl            = 30
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
    acm_certificate_arn = aws_acm_certificate.k1chn-com.arn
    ssl_support_method  = "sni-only"
  }

  # cloudfront takes *forever* to fully deploy
  wait_for_deployment = false
  depends_on = [aws_acm_certificate_validation.k1chn-com]
}
