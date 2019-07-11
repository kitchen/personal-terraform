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

resource "aws_route53_record" "k1chn-domainkey" {
  zone_id = aws_route53_zone.k1chn-com.zone_id
  name    = "gmail._domainkey"
  type    = "TXT"
  ttl     = "300"
  records = [
    "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiZBoRe//iygkGfTxxgZN3h4EsfHP79V225eGrixTe0sf+7i+SncgNrLaQLa127hCAn0HQICIdUh4TqiaHg9pbRB8Mr7Od3ip6T/g17JxeJ1i/6wG9ruUu0v8/55ZXEPVDmBVs/vm4Gqf4oDXNvrQtCAikumR22Oy+4q1HhwmZBl\"\"APcmrJAOT/PYQDc7hU25Nn4GIyHeRxl5iRYbR39d3k3Az2m8TnNnvwGf0rU54x5a771/7/iKfphJvk7iJWTCUpTHXzjwBGtUmOiATAunnXAXnTPPq+RJTjhJTCnOpfmphynMON9LRBG6br0Nby490Oe1PmHisQvi6OLOTdCnqVwIDAQAB"
  ]
}