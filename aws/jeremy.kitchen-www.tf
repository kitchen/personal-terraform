resource "aws_s3_bucket" "jeremy-kitchen" {
  bucket = "jeremy-kitchen-www"
  acl    = "private"
}

# resource "aws_route53_record" "jeremy-kitchen-a" {
#   zone_id = aws_route53_zone.jeremy-kitchen.zone_id
#   name    = "dev"
#   type    = "A"
#   alias {
#     name                   = aws_cloudfront_distribution.jeremy-kitchen.domain_name
#     zone_id                = aws_cloudfront_distribution.jeremy-kitchen.hosted_zone_id
#     evaluate_target_health = false
#   }
# }
# 
# resource "aws_route53_record" "www-jeremy-kitchen-a" {
#   zone_id = aws_route53_zone.jeremy-kitchen.zone_id
#   name    = "www.dev"
#   type    = "A"
#   alias {
#     name                   = aws_cloudfront_distribution.jeremy-kitchen.domain_name
#     zone_id                = aws_cloudfront_distribution.jeremy-kitchen.hosted_zone_id
#     evaluate_target_health = false
#   }
# }

resource "aws_acm_certificate" "jeremy-kitchen" {
  domain_name       = "jeremy.kitchen"
  validation_method = "DNS"
  provider          = aws.east
}

resource "aws_route53_record" "jeremy-kitchen-cert-validation" {
  for_each = {
    for dvo in aws_acm_certificate.jeremy-kitchen.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  zone_id = aws_route53_zone.jeremy-kitchen.zone_id
  ttl     = 60
}


resource "aws_acm_certificate_validation" "jeremy-kitchen" {
  certificate_arn         = aws_acm_certificate.jeremy-kitchen.arn
  validation_record_fqdns = [for record in aws_route53_record.jeremy-kitchen-cert-validation : record.fqdn]
  provider                = aws.east
}

# resource "aws_cloudfront_distribution" "jeremy-kitchen" {
#   origin {
#     domain_name = aws_s3_bucket.jeremy-kitchen.bucket_regional_domain_name
#     origin_id   = "jeremy-kitchen-origin"
#   }
# 
#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "dev.k1chn.com cloudfront distribution"
#   default_root_object = "index.html"
# 
#   aliases = ["dev.k1chn.com", "www.dev.k1chn.com"]
# 
#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "jeremy-kitchen-origin"
# 
#     compress = true
#     forwarded_values {
#       query_string = true
# 
#       cookies {
#         forward = "all"
#       }
#     }
# 
#     viewer_protocol_policy = "redirect-to-https"
# 
#     # lambda_function_association {
#     #   event_type = "origin-request"
#     #   lambda_arn = aws_lambda_function.cloudfront-index-redirects.qualified_arn
#     # }
#     min_ttl     = 0
#     max_ttl     = 30
#     default_ttl = 30
#   }
# 
#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }
# 
#   # logging_config {
#   #   bucket = 
#   # }
# 
#   viewer_certificate {
#     acm_certificate_arn = aws_acm_certificate.jeremy-kitchen.arn
#     ssl_support_method  = "sni-only"
#   }
# 
# 
# 
#   depends_on = [aws_acm_certificate_validation.jeremy-kitchen]
# }
