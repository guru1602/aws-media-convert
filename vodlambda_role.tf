resource "aws_iam_role" "vodlambda_role" {
  name               = "ivendi-${var.stage}-vodlambda-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "ivendi-${var.stage}-vodlambda-policy"
  role = aws_iam_role.vodlambda_role.name

  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
    {
			"Sid": "Logging",
			"Effect": "Allow",
			"Action": [
				"logs:CreateLogGroup",
				"logs:CreateLogStream*",
				"logs:PutLogEvents"
			],
			"Resource": [
				"*"
			]
		},
		{
			"Sid": "Passrole",
			"Effect": "Allow",
			"Action": [
				"iam:PassRole"
			],
			"Resource": [
				"${aws_iam_role.media_convert.arn}"
			]
		},
		{
			"Action": [
				"mediaconvert:*"
			],
			"Resource": [
				"*"
			],
			"Effect": "Allow",
			"Sid": "MediaConvertService"
		},
		{
			"Effect": "Allow",
			"Action": [
				"s3:Get*",
				"s3:Put*",
				"s3:List*"
			],
			"Resource": [
				"${aws_s3_bucket.ivendi-gb-consumer-duty.arn}/*"
			]
		}
	]
}
EOF

}
