terraform {
backend "s3" {
    bucket         = "chintu1989"  
    region         =  "ap-south-1"
    key            = "terraform.tfstate" 
    dynamodb_table = "terraform-state-lock-dynamo" 
    encrypt        = true
}
}