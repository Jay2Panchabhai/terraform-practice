module "vpc" {
    source = "./module/vpc"
    vpc_cidr = "10.0.0.0/16"
    public_subnet_cidr = "10.0.0.0/24"
    private_subnet_cidr = "10.0.1.0/24"
    public_az = "ap-south-1a"
    private_az = "ap-south-1b"
}

module "ec2" {
    source = "./module/ec2"
    ami = "ami-0e38835daf6b8a2b9"
    instance_type = "t3.micro"
    key_name = "demo.key"
    subnet_id = module.vpc.public_subnet_id
    sg_id = module.vpc.sg_id
}