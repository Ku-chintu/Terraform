provider "aws" {
    region = "us-east-1"
  
}
resource "aws_s3_bucket" "Day-5" {
    bucket = "terraform-day-5"
  
}
