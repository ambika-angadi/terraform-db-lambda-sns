# Create an SQS queue
resource "aws_sqs_queue" "example_queue" {
  name                      = "example-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_iam_policy" "sqs_policy" {
  name        = "sqs-policy"
  description = "IAM policy for SQS access"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "sqs:SendMessage",
        Effect   = "Allow",
        Resource = aws_sqs_queue.example_queue.arn,
      },
    ],
  })
}








