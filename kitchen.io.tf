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