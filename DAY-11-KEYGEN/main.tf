provider "aws" {
  region = "ap-south-1"
}

# Generate SSH key pair
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS key pair using the generated public key
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Save private key locally
resource "local_file" "private_key" {
  filename = "${path.module}/deployer-key.pem"
  content  = tls_private_key.ssh_key.private_key_pem
}

output "private_key_path" {
  value = local_file.private_key.filename
}
