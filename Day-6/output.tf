output "public_ip" {
    value = [for ec_2 in aws_instance.ec_2 : ec_2.public_ip]
  
}