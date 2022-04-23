resource "aws_elasticache_subnet_group" "default" {
  name       = "${var.namespace}-redis-subnet"
  subnet_ids = var.subnet_ids

  tags = var.tags

}

resource "aws_elasticache_replication_group" "default" {
  replication_group_id          = var.cluster_id
  replication_group_description = var.cluster_description
  security_group_ids            = [aws_security_group.redis-security-group.id]
  node_type                     = var.node_type
  port                          = var.port
  parameter_group_name          = var.parameter_group_name

  subnet_group_name          = aws_elasticache_subnet_group.default.name
  automatic_failover_enabled = var.automatic_failover_enabled
  replicas_per_node_group    = var.replicas_per_node_group
  num_cache_clusters         = var.num_cache_clusters
  tags = var.tags
}
