resource "aws_elasticache_subnet_group" "cpwi_redis_subnets" {
  name       = "cpwi-subnets-group-redis"
  subnet_ids = ["${aws_subnet.subnet_pub1.id}", "${aws_subnet.subnet_pub2.id}"]
}

resource "aws_elasticache_cluster" "cpwi_redis" {
  cluster_id           = "cpwi"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
  engine_version       = "5.0.6"
  port                 = 6379
  subnet_group_name    = "${aws_elasticache_subnet_group.cpwi_redis_subnets.id}"
}

