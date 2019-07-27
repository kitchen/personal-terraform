locals {
  # I could grab this from remote state file but meh
  kitchen-io-zone-id = "ZJO5J1TE9ZO35"
}

data "http" "ifconfig-me" {
  url = "https://ifconfig.me/"
}

resource "aws_route53_record" "pohara-kitchen-io" {
  zone_id = local.kitchen-io-zone-id
  name    = "pohara"
  ttl     = "30"
  type    = "A"

  records = [data.http.ifconfig-me.body]
}
