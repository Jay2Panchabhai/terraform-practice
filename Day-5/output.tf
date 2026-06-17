#output "public_subnet_1_id" {
# value = module.vpc.public_subnet_1_id
#}

output "public_subnet_2_id" {
  value = module.vpc.public_subnet_2_id
}

output "sg_id" {
    value = module.vpc.sg_id
}
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "asg_name" {
  value = module.asg.asg_name
}