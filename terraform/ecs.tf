resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled" #allows you to collect metrics and logs, helping with monitoring.
  }

  tags = {
    Name = "MyECSCluster"
  }
}

resource "aws_ecs_task_definition" "my_task" {
  family                   = "my-task-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256" # Example: 0.25 vCPU
  memory                   = "512" # Example: 512 MiB

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "my_service" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.private1.id, aws_subnet.private2.id]
    assign_public_ip = false
    security_groups = [aws_security_group.ecs_tasks_sg.id]
  }

  desired_count = 2

  load_balancer {
    target_group_arn = aws_lb_target_group.my_tg.arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [
    aws_lb_listener.my_listener
  ]
}
