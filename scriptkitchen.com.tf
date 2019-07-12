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