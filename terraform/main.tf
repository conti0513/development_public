provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "example" {
  ami           = "ami-0c08c226b5ff7874c" # AMI ID for Amazon Linux 2 in Tokyo
  instance_type = "t2.micro"
  key_name      = var.key_name

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
