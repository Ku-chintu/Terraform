resource "aws_instance" "import" {
    ami = "ami-0ddfba243cbee3768"
    instance_type = "t2.micro"
    key_name = "Mumbai-key"
    tags = {
      Name = "import-ec2"
    }  
}

######################### import command in console #######################
######################### terraform import aws_instance.my_instance i-0abcd1234efgh5678 ###############