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

resource "aws_route53_record" "kitchen-io-mx" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
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

resource "aws_route53_record" "kitchen-io-domainkey" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "gmail._domainkey"
  type    = "TXT"
  ttl     = "300"
  records = [
    "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAse7XYdK1u8mcAsIt+sxl5YCWf0Y0xidEe17OCxiek7Mekyli4OXG822pOXvoyPrnTjYvxqvS55N4JGmhclJr9TNVhEjB0n8L8ILMsPAEMjrhij/g02JfZZxiMW6C1g3TXH08HnseYb/NumMQs9F0qi8ELd9V8hevU29\"\"hacUbClObnvd9gLFRtK79Wgx5JNqdEuaJGyLpTI3TifU35jLF6rNM/AEplNEgACmWK6uHEV6BTeMUMwFPugOrpc64LjsTJX6MwjanxNXC/IWoLic75AgrVUuH1P8RZNwn+X3X39O4tFh4hIqh9oG6MteYtJLqsh26Vqejsfua3wBuy3jeowIDAQAB"
  ]
}

resource "aws_route53_record" "scriptkitchen-com-mx" {
  zone_id = aws_route53_zone.scriptkitchen-com.zone_id
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

resource "aws_route53_record" "scriptkitchen-com-domainkey" {
  zone_id = aws_route53_zone.scriptkitchen-com.zone_id
  name    = "gmail._domainkey"
  type    = "TXT"
  ttl     = "300"
  records = [
    "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjr8eBAnaCW/qx363+AevvZU9O+ZV/vk0XpOJeoPO7RaXzEGG0sUesNGUdS1ud3WwCxEbpoK5H/AN/Xb71CCDNMK8jVhqrdpKHEdCHhPe1+sbPr9KkpaI525nEzY7eT\"\"z+/4APk0fHPUP5nyOaVu4tDa0nNfjSRWWunM2rw5ypLUXWobieLmHbOzdtqKNN8AlF1mDb7ncMvsMJ6IwLaQsXRBJmOI6xvjM7jou+voWev2V2mPyN3J/51x3gVeWrtX7Qezg9PgaMtVZaWj31D4LIGnbCfxmDarRisAmmavNFz5EHIMyJ/EuBXeEowm/TACiLQo5N+uB3s992KXZ1jdllqQIDAQAB"
  ]
}
