variable "task_family" {
  default = "ecs-task"
}

variable "cpu" {
  default = 512
}

variable "memory" {
  default = 1024
}

variable "container_image" {
  default = "nginx"
}

variable "container_port" {
  default = 80
}

variable "execution_role_arn" {
  description = "IAM Role ARN for ECS Task Execution"
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = var.task_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory

  execution_role_arn = var.execution_role_arn
  container_definitions = jsonencode([
    {
      name  = var.task_family
      image = var.container_image
      cpu   = var.cpu
      memory = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
    }
  ])
}
