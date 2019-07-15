resource "aws_sns_topic" "topic" {
  name = "${var.env}-tpc-${var.name}"
}

resource "aws_lambda_function" "post_to_slack" {
  runtime          = "${var.engine}"
  function_name    = "${var.env}-lbd-${var.name}"

  filename         = "${var.file_name}"
  role             = "${aws_iam_role.role_lambda.arn}"
  handler          = "handler.index"
  source_code_hash = "${base64sha256(file("${var.file_name}"))}"

  environment {
    variables = {
      SLACK_URL = "${var.slack_url}"
      SLACK_CHANNEL = "${var.slack_channel}"
      SLACK_USER = "${var.slack_user}"
    }
  }
}

resource "aws_sns_topic_subscription" "subscription_lambda" {
  topic_arn = "${aws_sns_topic.topic.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.post_to_slack.arn}"
}

resource "aws_lambda_permission" "with_sns" {
  statement_id = "AllowExecutionFromSNS"
  action = "lambda:InvokeFunction"
  principal = "sns.amazonaws.com"
  function_name = "${aws_lambda_function.post_to_slack.arn}"
  source_arn = "${aws_sns_topic.topic.arn}"
}
