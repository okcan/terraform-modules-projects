resource "aws_cloudwatch_metric_alarm" "my_alarm" {
  alarm_name          = "my-metric-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 90
  alarm_description   = "This alarm is triggered when CPU utilization is above 90% for 2 periods."
  actions_enabled     = true
}

