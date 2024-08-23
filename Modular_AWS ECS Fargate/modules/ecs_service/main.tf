
variable "service_name" {
  default = "my-ecs-service"
}

variable "desired_count" {
  default = 2
}

variable "container_name" {
  default = "nginx"
}

variable "container_port" {
  default = 80
}

variable "cluster_id" {
  description = "The ECS cluster ID"
}

variable "task_definition_arn" {
  description = "The ARN of the ECS task definition"
}

variable "subnets" {
  description = "Subnets for the service"
}

variable "security_groups" {
  description = "Security groups for the service"
}

variable "target_group_arn" {
  description = "ARN of the target group for the load balancer"
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}
