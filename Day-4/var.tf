variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr_1a" {
    default = "10.0.0.0/20"
}

variable "public_subnet_cidr_1b" {
    default = "10.0.16.0/20"
}

variable "public_az_1a" {
    default = "ap-south-1a"
}

variable "public_az_1b" {
    default = "ap-south-1b"
}

variable "private_subnet_cidr_1a" {
    default = "10.0.32.0/20"
}

variable "private_subnet_cidr_1b" {
    default = "10.0.48.0/20"
}

variable "private_az_1a" {
    default = "us-east-1a"
}

variable "private_az_1b" {
    default = "ap-south-1b"
}

variable "ami" {
    default = "ami-0741dc526e1106ae5"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "key_name" {
    default = "web"
}

variable "desired" {
    default = 2
}

variable "min_size" {
    default = 1
}

variable "max_size" {
    default = 5 
}