provider "aws" {
    region = "ap-south-1"  
}

resource "aws_s3_bucket" "Name" {
  bucket = "chintu1989"
}

