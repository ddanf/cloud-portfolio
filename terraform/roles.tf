resource "aws_iam_role" "getRole" {
    name    = "${var.appName}_get_role"

    assume_role_policy  = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:Query",
                "dynamodb:Scan",
                "s3:GetBucketLocation",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
    EOF
}

resource "aws_iam_role" "postRole" {
    name    = "${var.appName}_post_role"

    assume_role_policy  = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "polly:SynthesizeSpeech",
                "dynamodb:PutItem",
                "dynamodb:UpdateItem",
                "sns:Publish",
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetBucketLocation",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
    }
    EOF
}

resource "aws_iam_role" "delRole" {
    name    = "${var.appName}_del_role"

    assume_role_policy  = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:DeleteItem",
                "sns:Publish",
                "s3:DeleteObject",
                "s3:GetBucketLocation",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "*"
            ]
        }
    ]    }
    EOF
}