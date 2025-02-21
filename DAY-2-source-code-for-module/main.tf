resource "aws_instance" "name" {
  ami = var.ami-id
  instance_type = var.aws_instance
  key_name = var.key
}
