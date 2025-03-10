provider "aws" {
    region = "ap-south-1"
  
}
resource "aws_sns_topic" "my_topic" {
  name = "cloud-watch-alerts"
}


resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.my_topic.arn
  protocol  = "email"
  endpoint  = "kumar.chintu1987@gmail.com"
}