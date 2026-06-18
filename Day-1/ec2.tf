resource "aws_instance" "ec2_block" {
    ami = "ami-0e38835daf6b8a2b9"
    instance_type = "t3.micro"
    key_name = "demo.key"
    vpc_security_group_ids = ["sg-02d54887c651c5f1b"] 
    user_data = file("/root/terraform-practice/Day-1/user_data.sh")

  root_block_device {
    volume_size = "10"
    volume_type = "gp3"
    }

    tags = {
        Name = "tf-instance"
    }
}


