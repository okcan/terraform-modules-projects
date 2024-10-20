
# RDS Subnet Group
resource "aws_db_subnet_group" "app" {
  name       = "app-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id
}

# RDS PostgreSQL Instance
resource "aws_db_instance" "app" {
  allocated_storage      = 20
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  db_name                = "appdb"
  username               = "appadmin"
  password               = "password"
  db_subnet_group_name   = aws_db_subnet_group.app.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
}
