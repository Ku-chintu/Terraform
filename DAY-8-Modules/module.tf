module "name" {
    source = "../DAY-2-source-code-for-module"
    ami-id = "ami-0ddfba243cbee3768"  
    aws_instance = "t2.micro"
    key = "Mumbai-ke"
}