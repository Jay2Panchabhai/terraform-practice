output "public_ip" {
    value = [for instance in aws_aws_instance.ec_2 : ec_2.public_ip]
  
}