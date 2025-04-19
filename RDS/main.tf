resource "aws_db_instance" "my_db" {
  engine           = "mysql"
  instance_class   = "db.t2.micro"
  allocated_storage = 10
  identifier       = "mydb-instance"
}

