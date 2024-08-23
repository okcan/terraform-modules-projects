
provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "iam_roles" {
  source = "./modules/iam_roles"
}

module "ecs_cluster" {
  source = "./modules/ecs_cluster"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "load_balancer" {
  source  = "./modules/load_balancer"
  subnets = module.vpc.public_subnets
  vpc_id  = module.vpc.vpc_id
}

module "fargate_task" {
  source = "./modules/fargate_task"
  execution_role_arn = module.iam_roles.ecs_task_execution_role_arn
}

module "ecs_service" {
  source               = "./modules/ecs_service"
  cluster_id           = module.ecs_cluster.id
  task_definition_arn  = module.fargate_task.ecs_task_definition_arn  # Use the correct output
  subnets              = module.vpc.private_subnets
  security_groups      = [module.security_groups.lb_sg]
  target_group_arn     = module.load_balancer.tg_arn
}
