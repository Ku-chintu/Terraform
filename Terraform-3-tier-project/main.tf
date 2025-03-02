# ################### public-ec2 ################
# resource "aws_instance" "Bastion-host-ec2" {
#     ami = "ami-0c50b6f7dc3701ddd"
#     instance_type = "t2.micro"
#     availability_zone = "ap-south-1a"
#     key_name = "Mumbai-key"
#     tags = {
#       Name = "public-ec2"
#     }
#     subnet_id = aws_subnet.public_subnet_1.id
#     vpc_security_group_ids = [aws_security_group.project_sg.id] 
# }

# ################### FE-ec2 #################
# resource "aws_instance" "FE-web-ec2" {
#     ami = "ami-0c50b6f7dc3701ddd"
#     instance_type = "t2.micro"
#     availability_zone = "ap-south-1a"
#     tags = {
#       Name = "FE-ec2"
#     }
#     key_name = "Mumbai-key"
#     subnet_id = aws_subnet.fe_subnet_1.id
#     vpc_security_group_ids = [aws_security_group.project_sg.id] 
# }
# ################### BE-ec2 #################
# resource "aws_instance" "BE-app-ec2" {
#     ami = "ami-0c50b6f7dc3701ddd"
#     instance_type = "t2.micro"
#     availability_zone = "ap-south-1a"
#     tags = {
#       Name = "BE-ec2"
#     }
#     key_name = "Mumbai-key"
#     subnet_id = aws_subnet.be_subnet_1.id
#     vpc_security_group_ids = [aws_security_group.project_sg.id] 
# }
######################### ubuntu ec2 resource block ######################################
####################### ec2-instance block ####################
################### public-ec2 ################
resource "aws_instance" "Bastion-host-ec2" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    key_name = "mumbai-ubuntu-key"
    tags = {
      Name = "public-ec2"
    }
    subnet_id = aws_subnet.public_subnet_1.id
    vpc_security_group_ids = [aws_security_group.project_sg.id] 
}

################### FE-ec2 #################
resource "aws_instance" "FE-web-ec2" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "FE-ec2"
    }
    key_name = "mumbai-ubuntu-key"
    subnet_id = aws_subnet.fe_subnet_1.id
    vpc_security_group_ids = [aws_security_group.project_sg.id] 
}
################### BE-ec2 #################
resource "aws_instance" "BE-app-ec2" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "BE-ec2"
    }
    key_name = "mumbai-ubuntu-key"
    subnet_id = aws_subnet.be_subnet_1.id
    vpc_security_group_ids = [aws_security_group.project_sg.id] 
}


############## VPC Endpoint to Connect BE and FE EC2 ################
resource "aws_ec2_instance_connect_endpoint" "example" {
  subnet_id = aws_subnet.public_subnet_1.id
  tags = {
     Name = "ec2-instance-connect-endpoint"
   }
}