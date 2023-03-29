provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "terraform_ec2" {
  ami           = "ami-0b828c1c5ac3f13ee"
  instance_type = "t2.micro"
  key_name      = "conti-2"
  vpc_security_group_ids = ["sg-0944e366cf3684556"]


  tags = {
    Name = "20230328-terraform-test"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/keys/conti-2.cer")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]
  }
}

resource "aws_security_group" "instance" {
  name_prefix = "2023-terraform-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.terraform_ec2.public_ip
  description = "Public IP address of the EC2 instance"
}
