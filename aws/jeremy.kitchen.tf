resource "aws_route53_zone" "jeremy-kitchen" {
  name    = "jeremy.kitchen"
  comment = "jeremy.kitchen"
}

resource "aws_route53_record" "jeremy-kitchen-keybase" {
  zone_id = aws_route53_zone.jeremy-kitchen.zone_id
  name    = "_keybase"
  type    = "TXT"
  ttl     = 300
  records = ["keybase-site-verification=lG1AYGOACYZCvuKJpk09wrLdhzSphMjUytCKlHGbJQY"]
}

resource "aws_route53_record" "jeremy-kitchen-caa" {
  zone_id = aws_route53_zone.jeremy-kitchen.zone_id
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
