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