resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "my_vpc"
  }
}

# Public Subnet 1

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.public_az_1
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_1"
  }
}

# Public Subnet 2

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.public_az_2
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_2"
  }
}

# Private Subnet

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_az

  tags = {
    Name = "private_subnet"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "igw"
  }
}

# Elastic IP

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat_eip"
  }
}

# NAT Gateway

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "nat_gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Public Route Table

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

# Public RT Association 1

resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Public RT Association 2

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private_rt"
  }
}

# Private RT Association

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# Security Group

resource "aws_security_group" "sg" {
  name        = "my-security-group"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-security-group"
  }
}