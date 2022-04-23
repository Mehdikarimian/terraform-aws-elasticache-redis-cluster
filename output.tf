output "primary_endpoint_address" {
  value = "${aws_elasticache_replication_group.default.primary_endpoint_address}"
}

output "arn" {
  value = aws_elasticache_subnet_group.default.arn
}

output "configuration_endpoint_address" {
  value = aws_elasticache_replication_group.default.configuration_endpoint_address
}

output "security_group_arn" {
  value = aws_security_group.redis-security-group.arn
}