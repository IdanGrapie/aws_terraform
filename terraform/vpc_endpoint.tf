#To allow your instances to communicate with the Amazon ECR API privately:
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id             = aws_vpc.main.id
  service_name       = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.private1.id, aws_subnet.private2.id]
  private_dns_enabled = true
  security_group_ids = [aws_security_group.ecr_vpc_endpoint_sg.id]

  tags = {
    Name = "ecr-api-endpoint"
  }
}


#To allow your instances to download Docker layers from ECR privately:
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id             = aws_vpc.main.id
  service_name       = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.private1.id, aws_subnet.private2.id]
  private_dns_enabled = true
  security_group_ids = [aws_security_group.ecr_vpc_endpoint_sg.id]

  tags = {
    Name = "ecr-dkr-endpoint"
  }
}

