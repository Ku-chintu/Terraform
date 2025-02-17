resource "aws_instance" "Day-5" {
    ami = "ami-053a45fff0a704a47"
    instance_type = "t2.micro"
    key_name = "usa-key"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Dev-ec2"
    }  
}