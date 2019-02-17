resource "aws_s3_bucket" "build" {
    bucket  = "${var.build_bucket}"
    acl     = "private"

    tags = {
        Aplication  = "${var.appName}"
        Name        = "build bucket"
    }
}

resource "aws_s3_bucket" "web" {
    bucket  = "${var.web_bucket}"
    acl     = "public-read"
    // policy  = "${aws_s3_bucket_policy.web_bucket_policy.policy}"

    website = {
        index_document  = "index.html"
        error_document  = "error.html"
    }

    tags    = {
        Application = "${var.appName}"
        Name        = "web bucket"
    }
}

resource "aws_s3_bucket_policy" "web_bucket_policy" {
    bucket  = "${aws_s3_bucket.web.id}"
    policy  = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.web_bucket}/*"
        }
    ]
}
POLICY
}