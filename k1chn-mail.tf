resource "aws_route53_record" "k1chn-mx" {
  zone_id = aws_route53_zone.k1chn-com.zone_id
  name    = ""
  type    = "MX"

  ttl = "300"
  records = [
    "1 aspmx.l.google.com",
    "10 aspmx2.googlemail.com",
    "10 aspmx3.googlemail.com",
    "5 alt1.aspmx.l.google.com"
  ]
}