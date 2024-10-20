
# ECS Cluster
resource "aws_ecs_cluster" "app_cluster" {
  name = "app-cluster"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "app_task" {
  family                = "app-task"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "256"
  memory                = "512"

  execution_role_arn    = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "app"
    image     = "nginx:latest"
    essential = true
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
  }])
}

# ECS Service
resource "aws_ecs_service" "app_service" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.private[*].id
    security_groups = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = "app"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.app_listener]
}
