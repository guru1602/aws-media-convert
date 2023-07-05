output "bucket_arn" {
  value = aws_s3_bucket.ivendi-gb-consumer-duty.arn
}

output "bucket_name" {
  value = aws_s3_bucket.ivendi-gb-consumer-duty.id
}

output "media_convert_role" {
    value = aws_iam_role.media_convert.arn
}

output "vodlambda_role" {
    value = aws_iam_role.vodlambda_role.arn
}
