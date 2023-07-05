resource "aws_s3_bucket" "ivendi-gb-consumer-duty" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.ivendi-gb-consumer-duty.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.ivendi-gb-consumer-duty.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

##################
# Adding S3 bucket as trigger to my lambda and giving the permissions
##################
resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
 depends_on = [aws_lambda_function.media_convert]
 
 bucket = aws_s3_bucket.ivendi-gb-consumer-duty.id
 lambda_function {
   lambda_function_arn = aws_lambda_function.media_convert.arn
   events              = ["s3:ObjectCreated:*"]
   filter_prefix       = "upload/"
  }
}
