resource "aws_db_instance" "my_rds_instance" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  name                 = "mydatabase"
  username             = "admin"
  password             = "123456"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.my_rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
  multi_az              = false

  tags = {
    Name = "MyRDSInstance"
  }
}


resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]

  tags = {
    Name = "MyDBSubnetGroup"
  }
}



resource "aws_security_group" "my_rds_sg" {
  name        = "my-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306 // Use the correct port for your database
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.ecs_worker_sg.id] // Allow access from ECS worker security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MyRDSSecurityGroup"
  }
}

output "rds_endpoint" { #to retrive my endpoint so i can use it in my script
  value = aws_db_instance.my_rds_instance.endpoint
}
