resource "aws_iam_role" "lambda_role" {
 name   = "terraform_aws_lambda_role"
 assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

# IAM policy for logging from a lambda

resource "aws_iam_policy" "iam_policy_for_lambda" {

  name         = "aws_iam_policy_for_terraform_aws_lambda_role"
  path         = "/"
  description  = "AWS IAM Policy for managing aws lambda role"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "iam_policy_for_lambda2" {

  name         = "aws_iam_policy_for_terraform_aws_lambda_role2"
  path         = "/"
  description  = "AWS IAM Policy for managing aws lambda role"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::hello-s3-20231022w/*"
        }
    ]
}
EOF
}
resource "aws_iam_policy" "iam_policy_for_lambda_sqs" {

  name         = "aws_iam_policy_for_terraform_aws_lambda_role_sqs"
  path         = "/"
  description  = "AWS IAM Policy for managing aws lambda role"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "sqs:*",
            "Resource": "*"
        }
    ]
}
EOF
}

# resource "aws_iam_policy" "iam_policy_for_lambda_sqs" {
#   name        = "aws_iam_policy_for_terraform_aws_lambda_role_sqs"
#   path        = "/"
#   description = "AWS IAM Policy for managing AWS Lambda role"
#   policy = <<EOF
#   {
#       "Version": "2012-10-17",
#       "Statement": [
#           {
#               "Sid": "VisualEditor0",
#               "Effect": "Allow",
#               "Action": "sqs:ReceiveMessage",
#               "Resource": aws_sqs_queue.example_queue.arn
#           }
#       ]
#   }
#   EOF
# }


# Policy Attachment on the role.

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role        = aws_iam_role.lambda_role.name
  policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role2" {
  role        = aws_iam_role.lambda_role.name
  policy_arn  = aws_iam_policy.iam_policy_for_lambda2.arn
}

# Attach policies to IAM roles
resource "aws_iam_policy_attachment" "sns_policy_attachment" {
  name       = "sns-policy-attachment"
  policy_arn = aws_iam_policy.sns_policy.arn
  roles      = [aws_iam_role.lambda_role.name]
}

resource "aws_iam_policy_attachment" "sqs_policy_attachment" {
  name       = "sqs-policy-attachment"
  policy_arn = aws_iam_policy.sqs_policy.arn
  roles      = [aws_iam_role.lambda_role.name]
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role_sqs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda_sqs.arn
}

