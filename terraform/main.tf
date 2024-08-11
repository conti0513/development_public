# Provider Configuration: Sets the AWS region to be used for deploying resources.
provider "aws" {
  region = var.aws_region  # Uses the AWS region defined in the variables below
}

# Security Group: Creates a security group allowing SSH access from a specific IP and permits all outbound traffic.
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_from_anywhere"  # Name of the security group
  description = "Allow SSH inbound traffic from a specific IP"  # Description of the security group
  vpc_id      = var.vpc_id  # The VPC ID where this security group will be created

  # Inbound rule: Allow SSH access on port 22 from a specific IP address
  ingress {
    from_port   = 22  # Start of port range (22 for SSH)
    to_port     = 22  # End of port range
    protocol    = "tcp"  # Protocol used, TCP for SSH
    cidr_blocks = [var.public_ip]  # Allow from specific IP address
  }

  # Outbound rule: Allow all outbound traffic
  egress {
    from_port   = 0  # Start of port range
    to_port     = 0  # End of port range
    protocol    = "-1"  # Protocol -1 allows all traffic
    cidr_blocks = ["0.0.0.0/0"]  # Allow to any IP address
  }

  tags = {
    Name = "allow_ssh_from_anywhere"  # Tag for the security group
  }
}

# EC2 Instance: Launches a t2.micro EC2 instance in the Tokyo region, attaching the security group for SSH access.
resource "aws_instance" "example" {
  ami           = "ami-0c08c226b5ff7874c" # Amazon Linux 2 AMI ID for Tokyo region
  instance_type = "t2.micro"  # Instance type (small and low cost)
  key_name      = var.key_name  # SSH key pair name, provided as a variable
  security_groups = [aws_security_group.allow_ssh.name]  # Attach the created security group

  tags = {
    Name = "TerraformExample"  # Tag for the EC2 instance
  }
}

# Variables: Used to configure the AWS region, SSH key pair, and VPC ID dynamically, making the configuration more flexible.

# AWS region
variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = "ap-northeast-1"  # Default to Tokyo region
}

# SSH key pair name
variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

# VPC ID
variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

# Public IP Address
variable "public_ip" {
  description = "The public IP address that will be allowed to SSH into the instance"
  type        = string
}
