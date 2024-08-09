# EC2 Instance
resource "aws_instance" "wordpress-01" {
  ami           = "ami-0b828c1c5ac3f13ee"
  instance_type = "t2.micro"
  key_name      = "conti-2"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = "wordpress-01"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/keys/conti-2.cer")
      host        = self.public_ip
    }
  }
}

# output "public_ip" {
#   value = aws_instance.wordpress-01.public_ip
# }

