# variable.tf

variable "aws_region" {
  default = "ap-northeast-1"
}

variable "aws_ami" {
  default = "ami-0b828c1c5ac3f13ee"
}

variable "aws_instance_type" {
  default = "t2.micro"
}

variable "aws_key_name" {
  default = "conti-2"
}

variable "aws_db_allocated_storage" {
  default = 10
}

variable "aws_db_engine" {
  default = "mysql"
}

variable "aws_db_engine_version" {
  default = "5.7"
}

variable "aws_db_instance_class" {
  default = "db.t2.micro"
}

variable "aws_db_name" {
  default = "db_name"
}

variable "aws_db_username" {
  default = "wordpress_admin"
}

variable "aws_db_password" {
  default = "testpassword"
}

