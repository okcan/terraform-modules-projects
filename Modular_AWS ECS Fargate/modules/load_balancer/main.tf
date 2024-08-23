
variable "subnets" {
  description = "Subnets for the Load Balancer"
}

variable "vpc_id" {
  description = "VPC ID for the Target Group"
}

module "lb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.11.0" # Updated version

  name               = "ecs-lb"
  load_balancer_type = "application"
  subnets            = var.subnets
  vpc_id             = var.vpc_id 
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "tg" {
  name        = "ecs-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  
}
