locals {
  subnet_group_name    = var.subnet_name == "" ? var.namespace : "${var.namespace}-${var.subnet_name}"
  parameter_group_name = var.cluster_mode ? "default.${var.family}.cluster.on" : "default.${var.family}"
}

resource "aws_elasticache_subnet_group" "default" {
  name       = local.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = var.tags
}

resource "aws_elasticache_parameter_group" "redis" {
  count  = var.parameter_group_name == "" ? 0 : 1
  name   = var.parameter_group_name
  family = var.family


  dynamic "parameter" {
    for_each = var.cluster_mode ? concat([{ name = "cluster-enabled", value = "yes" }], var.parameter) : var.parameter
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_elasticache_replication_group" "default" {
  replication_group_id = "${var.cluster_id}-${var.cluster_name}"
  description          = var.cluster_description
  security_group_ids   = [aws_security_group.redis-security-group.id]
  node_type            = var.node_type
  port                 = var.port

  subnet_group_name          = aws_elasticache_subnet_group.default.name
  automatic_failover_enabled = var.cluster_mode ? true : var.number_replica > 1 ? var.automatic_failover_enabled : false
  apply_immediately          = var.apply_immediately

  parameter_group_name = var.parameter_group_name == "" ? local.parameter_group_name : aws_elasticache_parameter_group.redis[0].name

  num_cache_clusters = var.cluster_mode ? null : var.number_replica

  num_node_groups         = var.cluster_mode ? var.number_shard : null
  replicas_per_node_group = var.cluster_mode ? var.number_replica : null


  tags = var.tags
}
