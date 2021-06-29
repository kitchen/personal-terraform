resource "aws_route53_record" "kitchen-io-txt" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = ""
  type    = "TXT"
  ttl     = "300"
  records = [
    "stripe-verification=7f3976bf9a1f3f48872d5715f52fc3000d63a8afdc3786b599a5fafff8266106"
  ]
}

resource "aws_route53_record" "stripe-kitchen-io-domainkeys-1" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "wdh77wadzuecsfkbi7l2kvutufjkzodt._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = [
    "wdh77wadzuecsfkbi7l2kvutufjkzodt.dkim.custom-email-domain.stripe.com."
  ]
}
resource "aws_route53_record" "stripe-kitchen-io-domainkeys-2" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "kn36nwclnaqh5k57xp5d3kzy2yajyqvw._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = [
    "kn36nwclnaqh5k57xp5d3kzy2yajyqvw.dkim.custom-email-domain.stripe.com."
  ]
}
resource "aws_route53_record" "stripe-kitchen-io-domainkeys-3" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "fff4ornfld6cgygry3mcckp7mie3ortn._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = [
    "fff4ornfld6cgygry3mcckp7mie3ortn.dkim.custom-email-domain.stripe.com."
  ]
}
resource "aws_route53_record" "stripe-kitchen-io-domainkeys-4" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "cb4nqzvdlwbsylkpmyag3kemlyx5jp2p._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = [
    "cb4nqzvdlwbsylkpmyag3kemlyx5jp2p.dkim.custom-email-domain.stripe.com."
  ]
}
resource "aws_route53_record" "stripe-kitchen-io-domainkeys-5" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "opi6hbni4hxi6krlzl47prx77b66kkgh._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = [
    "opi6hbni4hxi6krlzl47prx77b66kkgh.dkim.custom-email-domain.stripe.com."
  ]
}
resource "aws_route53_record" "stripe-kitchen-io-domainkeys-6" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "n5r4l7vjdjxcvoa2wdcf53v2gximaos4._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = [
    "n5r4l7vjdjxcvoa2wdcf53v2gximaos4.dkim.custom-email-domain.stripe.com."
  ]
}

resource "aws_route53_record" "bounce-kitchen-io-cname" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "bounce"
  type    = "CNAME"
  ttl     = "300"
  records = [
    "custom-email-domain.stripe.com."
  ]
}
