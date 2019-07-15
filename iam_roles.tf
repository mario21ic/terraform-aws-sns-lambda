resource "aws_iam_role" "role_lambda" {
  name = "role-for-${var.env}-lbd-${var.name}"

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

resource "aws_iam_role_policy" "policy_for_lambda" {
  name = "policy-for-${var.env}-lbd-${var.name}"
  role = "${aws_iam_role.role_lambda.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateLogStream"
            ],
            "Resource": [
                "arn:aws:logs:eu-west-1:794250218868:log-group:/aws/lambda/postToSlack:*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:eu-west-1:794250218868:log-group:/aws/lambda/postToSlack:*:*"
            ],
            "Effect": "Allow"
        }
    ]
}
EOF
}
