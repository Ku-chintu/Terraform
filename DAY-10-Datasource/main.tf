data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["subnet-1"] # insert value here
  }
}
data "aws_security_group" "selected" {
  filter {
    name   = "tag:Name"
    values = ["cust-sg-1"] # insert value here
  }
}

resource "aws_instance" "dev" {
    ami = "ami-0d682f26195e9ec0f"
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.selected.id
    vpc_security_group_ids = [data.aws_security_group.selected.id]
    tags = {
      Name = "ec2-server"
    }

}