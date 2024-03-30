resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Security group for ALB that allows inbound web traffic"
  vpc_id      = aws_vpc.main.id

  # Allow inbound HTTP traffic from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTPS traffic from anywhere (if you're using HTTPS)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALBSecurityGroup"
  }
}

#########################################

resource "aws_security_group" "ecs_worker_sg" {
  name        = "ecs-worker-security-group"
  description = "Security group for ECS worker nodes"
  vpc_id      = aws_vpc.main.id

  # Allow inbound traffic from the ALB on the application port
  # Adjust the from_port and to_port to match your application's port(s)
  ingress {
    from_port   = 80 # or the port your application uses
    to_port     = 80 # or the port your application uses
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ECSWorkerSecurityGroup"
  }
}


#########################
resource "aws_security_group" "ecr_vpc_endpoint_sg" {
  name        = "ecr-vpc-endpoint-sg"
  description = "Security group for ECR VPC Endpoint"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr] # or specific CIDR blocks as needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ECRVPCEndpointSG"
  }
}
