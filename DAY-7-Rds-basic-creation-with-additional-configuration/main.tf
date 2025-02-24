resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.medium"
  username             = "admin"
  password             = "admin12345"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true

 # Enable performance insights
  performance_insights_enabled = true
  performance_insights_retention_period = 7  # Retain insights for 7 days

  # Maintenance window
  maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)

  # Enable deletion protection (to prevent accidental deletion)
  deletion_protection = false

  # Subnet Group
  db_subnet_group_name = aws_db_subnet_group.sub-grp.name

}

# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring" {
  name = "rds-monitoring-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}

# IAM Policy Attachment for RDS Monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}


resource "aws_db_subnet_group" "sub-grp" {
  name       = "mycutsubnet"
  subnet_ids = ["subnet-01d201f5ed79b3b60", "subnet-01aba8e5f0d8ab968"]

  tags = {
    Name = "My DB subnet group"
  }
}
