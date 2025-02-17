output "Day-5-availability_zone" {
    value = aws_instance.Day-5.availability_zone
  
}

output "Day-5-public_ip" {
    value = aws_instance.Day-5.public_ip
  
}

output "Day-5-private_ip" {
    value = aws_instance.Day-5.private_ip
    sensitive = true
  
}