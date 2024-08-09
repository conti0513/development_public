# vpc.tf

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "vpc-wordpress" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id            = aws_vpc.vpc-wordpress.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "ap-northeast-1a"
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id            = aws_vpc.vpc-wordpress.id
  cidr_block        = "172.16.3.0/24"
  availability_zone = "ap-northeast-1c"
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = aws_vpc.vpc-wordpress.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "ap-northeast-1a"
}

resource "aws_subnet" "private_subnet_1c" {
  vpc_id            = aws_vpc.vpc-wordpress.id
  cidr_block        = "172.16.4.0/24"
  availability_zone = "ap-northeast-1c"
}

resource "aws_internet_gateway" "igw-wordpress" {
  vpc_id = aws_vpc.vpc-wordpress.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc-wordpress.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-wordpress.id
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc-wordpress.id
}

resource "aws_route_table_association" "public_subnet_1a_association" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_1c_association" {
  subnet_id      = aws_subnet.public_subnet_1c.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_1a_association" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_1c_association" {
  subnet_id      = aws_subnet.private_subnet_1c.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg"
  description = "web-sg"
  vpc_id      = aws_vpc.vpc-wordpress.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

