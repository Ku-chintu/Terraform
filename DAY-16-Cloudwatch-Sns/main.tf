# Create a CloudWatch Log Group
resource "aws_cloudwatch_log_group" "example_log_group" {
  name              = "/example/log/group"
  retention_in_days = 7
}

# Create a CloudWatch Metric Filter
resource "aws_cloudwatch_log_metric_filter" "example_metric_filter" {
  name           = "example-metric-filter"
  log_group_name = aws_cloudwatch_log_group.example_log_group.name
  pattern        = "{ $.statusCode = 200 }"

  metric_transformation {
    name      = "SuccessfulRequests"
    namespace = "ExampleNamespace"
    value     = "1"
  }
}

# Create a CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "example_alarm" {
  alarm_name          = "example-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = aws_cloudwatch_log_metric_filter.example_metric_filter.metric_transformation[0].name
  namespace           = aws_cloudwatch_log_metric_filter.example_metric_filter.metric_transformation[0].namespace
  period              = 60
  statistic           = "Sum"
  threshold           = 10

#   alarm_actions = [
#     "arn:aws:sns:us-west-2:123456789012:example-sns-topic"
#   ]

}
