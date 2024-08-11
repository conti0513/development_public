provider "aws" {
  region = var.aws_region
}

# Create a security group that allows SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

# Launch an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c08c226b5ff7874c" # AMI ID for Amazon Linux 2 in Tokyo
  instance_type = "t2.micro"
  key_name      = var.key_name
  security_groups = [aws_security_group.allow_ssh.name]  # Attach the security group

  tags = {
    Name = "TerraformExample"
  }
}

variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = "ap-northeast-1"  # Default to Tokyo region
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}
