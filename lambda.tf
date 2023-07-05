data "archive_file" "convert" {
  type        = "zip"
  source_dir = "./lambda/convert"
  output_path = "./lambda/dist/lambda.zip"
}

resource "aws_lambda_function" "media_convert" {
  
  filename         = data.archive_file.convert.output_path
  function_name    = "${var.stage}-vodlambda-convert"
  role             = aws_iam_role.vodlambda_role.arn
  handler          = "convert.handler"
  runtime          = "python3.7"
  source_code_hash = filebase64sha256(data.archive_file.convert.output_path)
  description      = "compress media files"
  memory_size      = 128
  timeout          = 300  
  environment {
    variables = {
      DestinationBucket  = "${aws_s3_bucket.ivendi-gb-consumer-duty.id}"
      MediaConvertRole   = "${aws_iam_role.media_convert.arn}"
      Application        = "consumerduty"
    }
  } 
}

resource "aws_lambda_permission" "media_convert" {
  depends_on = [aws_lambda_function.media_convert]

  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.media_convert.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.ivendi-gb-consumer-duty.arn
}
