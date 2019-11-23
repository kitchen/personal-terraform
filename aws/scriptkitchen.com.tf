resource "aws_route53_zone" "scriptkitchen-com" {
  name    = "scriptkitchen.com"
  comment = "scriptkitchen.com"
}

resource "aws_route53_record" "scriptkitchen-com-keybase" {
  zone_id = aws_route53_zone.scriptkitchen-com.zone_id
  name    = "_keybase"
  ttl     = "300"
  type    = "TXT"

  records = [
    "keybase-site-verification=ImQh-GRXOfa9Wj1djbMAgGvwzc58MndGej347KFeFP8"
  ]
}

resource "aws_route53_record" "scriptkitchen-com" {
  zone_id = aws_route53_zone.scriptkitchen-com.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = local.s3_alias_target
    zone_id                = local.s3_alias_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-scriptkitchen-com" {
  zone_id = aws_route53_zone.scriptkitchen-com.zone_id
  name    = "www"
  type    = "A"

  alias {
    name                   = local.s3_alias_target
    zone_id                = local.s3_alias_zone_id
    evaluate_target_health = false
  }
}

# s3 bucket scriptkitchen.com
# s3 bucket www.scriptkitchen.com
