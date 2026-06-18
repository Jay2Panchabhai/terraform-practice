resource "aws_instance" "web" {
  ami           = "ami-0e38835daf6b8a2b9" # Ubuntu 22.04 (Mumbai)
  instance_type = "t3.micro"

  tags = {
    Name = "Terraform-EC2"
  }
}


