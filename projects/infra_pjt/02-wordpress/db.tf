# db.tf

# DB Subnet Group
resource "aws_db_subnet_group" "wordpress_db_subnet_group" {
  name        = "wordpress-db-subnet-group"
  description = "wordpress-db-subnet-group"
  subnet_ids  = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1c.id]
}

# RDS Instance
resource "aws_db_instance" "wordpress_rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = "wordpress-rds"
  name                 = "db_name"
  username             = "wordpress_admin"
  password             = "testpassword"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.wordpress_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

# output "rds_endpoint" {
#   value = aws_db_instance.wordpress_rds.endpoint
# }

