// place CloudFront distribution description in this file.

resource "aws_cloudfront_distribution" "webCDN" {
      origin {
    domain_name = "${aws_s3_bucket.web.website_endpoint}"
    origin_id = "${aws_s3_bucket.web.id}"
  }

  enabled = true
  default_root_object = "index.html"

  aliases = [
    "domain1.com",
    "domain2.com"
  ]

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${aws_s3_bucket.web.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }

  # Use only edge servers in USA and EU.
  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

viewer_certificate {
    cloudfront_default_certificate = true
  }

}