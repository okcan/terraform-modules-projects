
variable "cluster_name" {
  default = "my-ecs-cluster"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}
