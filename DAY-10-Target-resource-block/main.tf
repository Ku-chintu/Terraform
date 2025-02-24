resource "aws_instance" "dependent" {
    ami = "ami-0d682f26195e9ec0f"
    instance_type = "t2.micro"
    key_name = "public"
}

resource "aws_s3_bucket" "dependent" {
    bucket = "target-block" 
}

#terraform apply -target=aws_s3_bucket.dependent
#terraform destroy -target=aws_s3_bucket.dependent

#Example below for multiple targets
#terraform apply -target=aws_s3_bucket.dependent -target=aws_instance.dev -target=aws_db_instance.database