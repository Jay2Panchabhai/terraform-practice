# resource "aws_s3_bucket" "s3" {
# }

#####TERRAFORM LOOPS#######
resource "aws_instance" "ec_2" {
    for_each = tomap({
        ec2-1 = "t3.micro"
        ec2-2 = "t2.small"
        ec2-3 = "c7i-flex.large"
    })

    ami = "ami-0e38835daf6b8a2b9"
    instance_type = each.value
    tags = {
         Name = each.key
     }
  
}