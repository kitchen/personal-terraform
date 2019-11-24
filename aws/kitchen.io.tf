resource "aws_route53_zone" "kitchen-io" {
  name    = "kitchen.io"
  comment = "kitchen.io"
}

resource "aws_route53_record" "kitchen-io-keybase" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "_keybase"
  ttl     = "300"
  type    = "TXT"

  records = [
    "keybase-site-verification=oUZxhV9TMgcfPwsuSPkJCYU9No2x_SkkR3P7SfQ_Mh4"
  ]
}

resource "aws_route53_record" "words-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "words"
  ttl     = "300"
  type    = "A"

  records = ["64.111.117.224"]
}

resource "aws_route53_record" "www-words-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "www.words"
  ttl     = "300"
  type    = "A"

  records = ["64.111.117.224"]
}

resource "aws_route53_record" "devblog-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "devblog"
  ttl     = "300"
  type    = "A"

  records = ["75.119.217.253"]
}

resource "aws_route53_record" "kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = local.s3_alias_target
    zone_id                = local.s3_alias_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "www"
  type    = "A"

  alias {
    name                   = local.s3_alias_target
    zone_id                = local.s3_alias_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "blog-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "blog"
  type    = "A"

  alias {
    name                   = local.s3_alias_target
    zone_id                = local.s3_alias_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-blog-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "www.blog"
  type    = "A"

  alias {
    name                   = local.s3_alias_target
    zone_id                = local.s3_alias_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "kitchen-io-caa" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "."
  type    = "CAA"
  ttl     = 300
  records = [
    "0 issue \"amazon.com\"",
    "0 issue \"pki.goog\"",
    "0 issue \"letsencrypt.org\"",
    "0 iodef \"mailto:kitchen@kitchen.io\"",
  ]
}

# s3 bucket kitchen.io
# s3 bucket www.kitchen.io
# s3 bucket blog.kitchen.io
# s3 bucket www.blog.kitchen.io
