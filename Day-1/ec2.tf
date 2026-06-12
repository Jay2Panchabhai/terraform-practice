resource "aws_instance" "ec2_block" {
    ami = "ami-0db56f446d44f2f09"
    instance_type = "t3.micro"
    key_name = "demo.key"
    vpc_security_group_ids = ["sg-0f034c503a772275a"] 
    user_data = file("/root/terraform-practice/Day1/user_data.sh")

  root_block_device {
    volume_size = "10"
    volume_type = "gp3"
    }

    tags = {
        Name = "tf-instance"
    }
}


