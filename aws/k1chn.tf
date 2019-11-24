
resource "aws_s3_bucket" "kitchen-logs-bucket" {
  bucket = "kitchen-logs-bucket"
  acl    = "private"
}

resource "aws_route53_zone" "k1chn-com" {
  name    = "k1chn.com"
  comment = "k1chn.com"
}


resource "aws_route53_record" "k1chn-com-google" {
  zone_id = aws_route53_zone.k1chn-com.zone_id
  name    = "."
  type    = "TXT"
  ttl     = 300
  records = ["google-site-verification=4F22G9eDIka8wlNx2L22MIvzz6T0F9f7U4gUsu5YoEo"]
}

resource "aws_route53_record" "k1chn-com-keybase" {
  zone_id = aws_route53_zone.k1chn-com.zone_id
  name    = "_keybase"
  type    = "TXT"
  ttl     = 300
  records = ["keybase-site-verification=VoTtE4BZ-4lGoH4_jOd-ZvX3IQQTDdjehHzjqc4UkaU"]
}

resource "aws_route53_record" "k1chn-com-caa" {
  zone_id = aws_route53_zone.k1chn-com.zone_id
  name    = "."
  type    = "CAA"
  ttl     = 300
  records = [
    "0 issue \"amazon.com\"",
    "0 iodef \"mailto:k1chn@k1chn.com\""
  ]
}
