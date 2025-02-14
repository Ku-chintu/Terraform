variable "ami-id" {
  type        = string   # Data type (optional but recommended)
  description = "Description of the ap-south-1 ami"
  default     = ""  # Default value (optional)
}

variable "aws_instance" {
  type        = string   # Data type (optional but recommended)
  description = "Description of the instance tye"
  default     = ""  # Default value (optional)
}

variable "key" {
  type        = string   # Data type (optional but recommended)
  description = "Description of the keypair"
  default     = ""  # Default value (optional)
}
