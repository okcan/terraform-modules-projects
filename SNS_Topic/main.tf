resource "aws_sns_topic" "my_topic" {
  name = "my-sns-topic"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.my_topic.arn
  protocol  = "email"
  endpoint  = "example@example.com"
}

