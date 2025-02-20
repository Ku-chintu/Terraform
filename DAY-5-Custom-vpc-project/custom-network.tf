###############    custom vpc    #############
resource "aws_vpc" "project" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "cust-vpc"
    }
  
}
########## internet gateway  #########
resource "aws_internet_gateway" "project-ig" {
    vpc_id = aws_vpc.project.id

    tags = {
        Name = "cust-ig"
    }  
}
###############- public subnet  ############
resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.project.id
    availability_zone = "ap-south-1a"
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "public-subnet"
    }
     
}
############ private subnet ###################
resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.project.id
    availability_zone = "ap-south-1a"
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "private-subnet"
    }
     
}
############## public route table ################
resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.project.id

    ############ edit route block ###########
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.project-ig.id
    }
    tags = {
      Name = "pub-rt"
    }
  
}

################# edit subnet association ##############
resource "aws_route_table_association" "public-rt" {
    route_table_id = aws_route_table.public-rt.id
    subnet_id = aws_subnet.public-subnet.id
  
}
################# security group ##################
resource "aws_security_group" "project-sg" {
  name        = "project-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.project.id

  #### Inbound Rules ######
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  ###### Allow SSH from anywhere #########
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  ######### Allow HTTP from anywhere #######
  }

  ########### Outbound Rules ###################
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  ###### in terraform '-1' means all traffic ######
    cidr_blocks = ["0.0.0.0/0"] ############ all traffic #########
  }

  tags = {
    Name = "project-sg"
  }
}

