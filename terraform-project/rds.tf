#################### rds block #################


resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "admin12345"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  
db_subnet_group_name = aws_db_subnet_group.sub-grp.id
#vpc_security_group_ids = [aws_security_group.project-sg.id]
}

resource "aws_db_subnet_group" "sub-grp" {
# depends_on = [aws_subnet.merged_subnets]
  name       = "mycutsubnet"
  subnet_ids = [aws_subnet.rds_subnet_1.id,aws_subnet.rds_subnet_2.id]
  tags = {
    Name = "rds-group"
  }
}
output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}