# Create an SNS topic
resource "aws_sns_topic" "example_topic" {
  name = "example-topic"
}

# Define IAM policies for SNS and SQS access
resource "aws_iam_policy" "sns_policy" {
  name        = "sns-policy"
  description = "IAM policy for SNS access"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "sns:Publish",
        Effect   = "Allow",
        Resource = aws_sns_topic.example_topic.arn,
      },
    ],
  })
}

# Subscribe the SQS queue to the SNS topic
resource "aws_sns_topic_subscription" "sqs_subscription" {
  topic_arn = aws_sns_topic.example_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.example_queue.arn
}




