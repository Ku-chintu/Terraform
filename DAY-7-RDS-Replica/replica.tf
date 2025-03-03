resource "aws_db_instance" "replica" {
  replicate_source_db       = "arn:aws:rds:ap-south-1:746669198895:db:terraform-20250228231011754400000001"
  instance_class            = "db.t3.medium"
  availability_zone         = "ap-south-1c"  # Choose a different AZ for high availability
  skip_final_snapshot       = true
  db_subnet_group_name      = aws_db_subnet_group.sub-grp.id

  # Optional settings
  deletion_protection = false

  tags = {
    Name = "mydb-replica"
  }
}
