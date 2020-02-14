# Defines a user that should be able to write to you test bucket
resource "aws_iam_user" "s3_cpwi" {
    name = "s3_cpwi"
}

resource "aws_iam_access_key" "s3_cpwi" {
    user = "${aws_iam_user.s3_cpwi.name}"
}

resource "aws_iam_user_policy" "s3_cpwi_rw" {
    name = "cpwi_s3_policy"
    user = "${aws_iam_user.s3_cpwi.name}"
    policy= <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::cpwi",
                "arn:aws:s3:::cpwi/*"
            ]
        }
   ]
}
EOF
}

resource "aws_s3_bucket" "cpwi" {
    bucket = "cpwi"
    acl = "public-read"

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT","POST"]
        allowed_origins = ["*"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }
    
    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetTestBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::cpwi/*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.s3_cpwi.arn}"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::cpwi",
                "arn:aws:s3:::cpwi/*"
            ]
        }
    ]
}
EOF
}  

