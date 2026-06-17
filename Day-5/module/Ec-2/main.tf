resource "aws_instance" "public_instance" {
    ami = var.ami 
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id =  var.subnet_id 
    vpc_security_group_ids = [var.sg_id]
    user_data = file("${path.module}/user_data.sh")
    tags = {
        Name = "public-instance"
    }
}