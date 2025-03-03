provider "aws" {
  region = "ap-south-1"
  
}
variable "db_username" {}
variable "db_password" {}

resource "aws_db_instance" "primary" {
  identifier                  = "primary-db-instance"  # Explicit identifier
  allocated_storage           = 20
  max_allocated_storage       = 100
  db_name                     = "mydb"
  engine                      = "mysql"
  engine_version              = "8.0"
  instance_class              = "db.t3.micro"
  username                    = var.db_username
  password                    = var.db_password
  parameter_group_name        = "default.mysql8.0"
  skip_final_snapshot         = true
  backup_retention_period     = 7
  publicly_accessible         = false
  iam_database_authentication_enabled = true
}

# resource "time_sleep" "wait_for_db" {
#   depends_on = [aws_db_instance.primary]
#   create_duration = "300s" # Wait for 5 minutes
#   }

# Wait for the primary database to be available
data "aws_db_instance" "primary_status" {
    db_instance_identifier = aws_db_instance.primary.id  # Use explicit identifier
}

resource "aws_db_instance" "read_replica" {
  depends_on = [data.aws_db_instance.primary_status]  # Ensure primary is created first
  instance_class              = "db.t3.micro"
  replicate_source_db         =  "primary-db-instance"  # Use explicit identifier
  parameter_group_name        = "default.mysql8.0"
  skip_final_snapshot         = true
  publicly_accessible         = false
   
  #  lifecycle {
  #   ignore_changes = [replicate_source_db]
  # }
}


