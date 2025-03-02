############### Custom VPC #############
resource "aws_vpc" "project" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "cust-vpc"
    }
}

########## Internet Gateway #########
resource "aws_internet_gateway" "project_ig" {
    vpc_id = aws_vpc.project.id
    tags = {
        Name = "cust-ig"
    }
}

############### Public Subnets ############
resource "aws_subnet" "public_subnet_1" {
    vpc_id                  = aws_vpc.project.id
    cidr_block              = "10.0.0.0/24"
    availability_zone       = "ap-south-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-1"
    }
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id                  = aws_vpc.project.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "ap-south-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-2"
    }
}

############## Public Route Table ################
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.project.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.project_ig.id
    }

    tags = {
        Name = "public-rt"
    }
}

############## Public Subnet Associations ##############
resource "aws_route_table_association" "public_rt_subnet_1" {
    route_table_id = aws_route_table.public_rt.id
    subnet_id      = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "public_rt_subnet_2" {
    route_table_id = aws_route_table.public_rt.id
    subnet_id      = aws_subnet.public_subnet_2.id
}

#### Elastic IP for NAT Gateway ####
resource "aws_eip" "nat_eip" {
    domain = "vpc"
}

#### NAT Gateway ####
resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id     = aws_subnet.public_subnet_1.id

    tags = {
        Name = "nat-gateway"
    }
}

############### Front-End Subnets ############
resource "aws_subnet" "fe_subnet_1" {
    vpc_id            = aws_vpc.project.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "ap-south-1a"
    tags = {
        Name = "FE-subnet-1"
    }
}

resource "aws_subnet" "fe_subnet_2" {
    vpc_id            = aws_vpc.project.id
    cidr_block        = "10.0.3.0/24"
    availability_zone = "ap-south-1b"
    tags = {
        Name = "FE-subnet-2"
    }
}

############### Back-End Subnets ############
resource "aws_subnet" "be_subnet_1" {
    vpc_id            = aws_vpc.project.id
    cidr_block        = "10.0.4.0/24"
    availability_zone = "ap-south-1a"
    tags = {
        Name = "BE-subnet-1"
    }
}

resource "aws_subnet" "be_subnet_2" {
    vpc_id            = aws_vpc.project.id
    cidr_block        = "10.0.5.0/24"
    availability_zone = "ap-south-1b"
    tags = {
        Name = "BE-subnet-2"
    }
}

############### RDS Subnets ############
resource "aws_subnet" "rds_subnet_1" {
    vpc_id            = aws_vpc.project.id
    cidr_block        = "10.0.6.0/24"
    availability_zone = "ap-south-1a"
    tags = {
        Name = "RDS-subnet-1"
    }
}

resource "aws_subnet" "rds_subnet_2" {
    vpc_id            = aws_vpc.project.id
    cidr_block        = "10.0.7.0/24"
    availability_zone = "ap-south-1b"
    tags = {
        Name = "RDS-subnet-2"
    }
}

############## Private Route Table ################
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.project.id

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway.id
    }

    tags = {
        Name = "private-rt"
    }
}

############## Private Subnet Associations ##############
resource "aws_route_table_association" "private_rt_fe_1" {
    route_table_id = aws_route_table.private_rt.id
    subnet_id      = aws_subnet.fe_subnet_1.id
}

resource "aws_route_table_association" "private_rt_fe_2" {
    route_table_id = aws_route_table.private_rt.id
    subnet_id      = aws_subnet.fe_subnet_2.id
}

resource "aws_route_table_association" "private_rt_be_1" {
    route_table_id = aws_route_table.private_rt.id
    subnet_id      = aws_subnet.be_subnet_1.id
}

resource "aws_route_table_association" "private_rt_be_2" {
    route_table_id = aws_route_table.private_rt.id
    subnet_id      = aws_subnet.be_subnet_2.id
}

resource "aws_route_table_association" "private_rt_rds_1" {
    route_table_id = aws_route_table.private_rt.id
    subnet_id      = aws_subnet.rds_subnet_1.id
}

resource "aws_route_table_association" "private_rt_rds_2" {
    route_table_id = aws_route_table.private_rt.id
    subnet_id      = aws_subnet.rds_subnet_2.id
}

################# Security Group ##################
resource "aws_security_group" "project_sg" {
    name        = "project-sg"
    description = "Allow SSH, HTTP, and MySQL traffic"
    vpc_id      = aws_vpc.project.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "project-sg"
    }
}
