################### public-ec2 ################
resource "aws_instance" "public-ec2" {
    ami = "ami-0c50b6f7dc3701ddd"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    key_name = "Mumbai-key"
    tags = {
      Name = "public-ec2"
    }
    subnet_id = aws_subnet.public-subnet.id
    vpc_security_group_ids = [aws_security_group.project-sg.id] 
}

################### private-ec2 #################
resource "aws_instance" "private-ec2" {
    ami = "ami-0c50b6f7dc3701ddd"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1b"
    tags = {
      Name = "private-ec2"
    }
    key_name = "Mumbai-key"
    subnet_id = aws_subnet.private-subnet.id
    vpc_security_group_ids = [aws_security_group.project-sg.id] 
}