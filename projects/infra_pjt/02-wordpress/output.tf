# output.tf

output "public_ip" {
  value = aws_instance.wordpress-01.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.wordpress_rds.endpoint
}
