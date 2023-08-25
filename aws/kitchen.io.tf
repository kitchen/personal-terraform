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

resource "aws_route53_record" "kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = local.s3_alias_target
    zone_id                = local.s3_alias_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "www"
  type    = "A"

  alias {
    name                   = local.s3_alias_target
    zone_id                = local.s3_alias_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "blog-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "blog"
  type    = "A"

  alias {
    name                   = local.s3_alias_target
    zone_id                = local.s3_alias_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-blog-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "www.blog"
  type    = "A"

  alias {
    name                   = local.s3_alias_target
    zone_id                = local.s3_alias_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "kitchen-io-caa" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
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

# s3 bucket kitchen.io
resource "aws_s3_bucket" "kitchen-io" {
  bucket = "kitchen.io"
}

resource "aws_s3_bucket_website_configuration" "kitchen-io" {
  bucket = aws_s3_bucket.kitchen-io.id

  redirect_all_requests_to {
    host_name = "words.kitchen.io"
    protocol = "http"
  }
}

# s3 bucket www.kitchen.io
resource "aws_s3_bucket" "www-kitchen-io" {
  bucket = "www.kitchen.io"
}

resource "aws_s3_bucket_website_configuration" "www-kitchen-io" {
  bucket = aws_s3_bucket.www-kitchen-io.id

  redirect_all_requests_to {
    host_name = "words.kitchen.io"
    protocol = "http"
  }
}

# s3 bucket blog.kitchen.io
resource "aws_s3_bucket" "blog-kitchen-io" {
  bucket = "blog.kitchen.io"
}

resource "aws_s3_bucket_website_configuration" "blog-kitchen-io" {
  bucket = aws_s3_bucket.blog-kitchen-io.id

  index_document {
    suffix = "index.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = ""
    }

    redirect {
      replace_key_with = "@kitchen"
      host_name = "simian.rodeo"
      protocol = "https"
    }
  }
}

# s3 bucket www.blog.kitchen.io
resource "aws_s3_bucket" "www-blog-kitchen-io" {
  bucket = "www.blog.kitchen.io"
}

resource "aws_s3_bucket_website_configuration" "www-blog-kitchen-io" {
  bucket = aws_s3_bucket.www-blog-kitchen-io.id

  index_document {
    suffix = "index.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = ""
    }

    redirect {
      replace_key_with = "@kitchen"
      host_name = "simian.rodeo"
      protocol = "https"
    }
  }
}


# delegation to wordpress.com for wordstest.kitchen.io
resource "aws_route53_record" "wordstest-kitchen-io-wordpress-delegation" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "wordstest"
  type    = "NS"
  ttl     = "300"
  records = [
    "ns1.wordpress.com",
    "ns2.wordpress.com",
    "ns3.wordpress.com",
  ]
}

# delegation to wordpress.com for wordstest.kitchen.io
resource "aws_route53_record" "words-kitchen-io-wordpress-delegation" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "words"
  type    = "NS"
  ttl     = "300"
  records = [
    "ns1.wordpress.com",
    "ns2.wordpress.com",
    "ns3.wordpress.com",
  ]
}

# the mac mini
resource "aws_route53_record" "hamilton-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "hamilton"
  type    = "A"
  ttl     = "3600"
  records = [
    "100.97.213.119"
  ]
}

# laptop
resource "aws_route53_record" "taipei-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "taipei"
  type    = "A"
  ttl     = "3600"
  records = [
    "100.97.38.104"
  ]
}

# phone
resource "aws_route53_record" "nara-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "nara"
  type    = "A"
  ttl     = "3600"
  records = [
    "100.126.189.101"
  ]
}

# singapore vpn box via digitalocean
resource "aws_route53_record" "daegu-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "daegu"
  type    = "A"
  ttl     = "3600"
  records = [
    "100.114.121.27"
  ]
}

# VA vpn box via dreamcompute
resource "aws_route53_record" "doe-kitchen-io" {
  zone_id = aws_route53_zone.kitchen-io.zone_id
  name    = "doe"
  type    = "A"
  ttl     = "3600"
  records = [
    "100.84.18.112"
  ]
}

