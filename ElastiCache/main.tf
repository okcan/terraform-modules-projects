resource "aws_elasticache_cluster" "my_cache_cluster" {
  cluster_id           = "my-cache-cluster"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
}

