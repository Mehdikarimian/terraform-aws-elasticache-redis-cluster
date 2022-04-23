variable "namespace" {
}

variable "node_groups" {
  description = "Number of nodes groups to create in the"
  default     = 1
}

variable "cluster_id" {
  description = "cluster name"
  default = "redis-cluster"
}

variable "cluster_description" {
  description = "cluster description"
  default = ""
}

variable "port" {
  description = "running port"
  default = 6379
}

variable "automatic_failover_enabled" {
  description = ""
  default = true
}

variable "security_group_name" {
  description = "redis security group name"
}

variable "replicas_per_node_group" {
  description = "number of replicas run per node group"
}

variable "parameter_group_name" {
  description = "parameter group name"
}

variable "node_type" {
  description = "node type"
}

variable "subnet_ids" {
  description = "subnets"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "tags" {
  description = "tags"
  type =  map(string)
}
