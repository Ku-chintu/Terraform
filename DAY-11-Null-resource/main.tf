provider "aws" {
    region = "ap-south-1"  
}

resource "aws_instance" "dev" {
    ami = "ami-0c50b6f7dc3701ddd"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    key_name = "Mumbai-key"
    tags = {
      Name = "public-ec2"
    }
}

resource "null_resource" "null_resource_test" {

    ####### case-1 #####
    triggers = {
      id = aws_instance.dev.id
    }
    ####### case-2 ######
    provisioner "local-exec" {
        command = "echo hello world"      
    }  
}