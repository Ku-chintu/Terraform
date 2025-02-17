resource "aws_instance" "project" {
    ami = "ami-0c50b6f7dc3701ddd"
    instance_type = "t2.micro"
    key_name = "Mumbai-key"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "custom-vpc-nat-ec2"
    }
    subnet_id = aws_subnet.private-subnet.id
    vpc_security_group_ids = [aws_security_group.project-sg.id]

  
}