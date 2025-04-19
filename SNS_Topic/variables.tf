variable "sns_topic_name" {
  description = "Name for the SNS topic"
  type        = string
  default     = "my-sns-topic"
}

variable "email_subscription_endpoint" {
  description = "Email address for subscription"
  type        = string
  default     = "example@example.com"
}

