resource "aws_s3_bucket" "example" {
  bucket = "dependent-block"  
}

resource "aws_instance" "dev" {
    ami = "ami-0d682f26195e9ec0f"
    instance_type = "t2.micro"
    depends_on = [ aws_s3_bucket.example]
    tags = {
      Name = "ec2-server"
    }
}