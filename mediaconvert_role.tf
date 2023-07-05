resource "aws_iam_role" "media_convert" {
  name = "ivendi-${var.stage}-mediaconvert-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "mediaconvert.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "media_convert" {
  name = "ivendi-${var.stage}-mediaconvert-policy"
  role = aws_iam_role.media_convert.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": [
                "${aws_s3_bucket.ivendi-gb-consumer-duty.arn}/upload/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:Put*"
            ],
            "Resource": [
                "${aws_s3_bucket.ivendi-gb-consumer-duty.arn}/videos/*"
            ]
        }
    ]
}
EOF
}
