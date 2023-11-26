# Create a lambda function
# In terraform ${path.module} is the current directory.
resource "aws_lambda_function" "sns_sqs_lambda_func" {
 filename                       = "${path.module}/python/hello-python.zip"
 function_name                  = "hello-post"
 role                           = aws_iam_role.lambda_role.arn
 handler                        = "lambda.lambda_handler"
 runtime                        = "python3.11"
}

# Generates an archive from content, a file, or a directory of files.

data "archive_file" "zip_the_python_code" {
 type        = "zip"
 source_dir  = "${path.module}/python/"
 output_path = "${path.module}/python/hello-python.zip"
}

#Event source from SQS
resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = aws_sqs_queue.example_queue.arn
  enabled          = true
  function_name    = aws_lambda_function.sns_sqs_lambda_func.arn
  batch_size       = 1
}