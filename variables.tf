variable "namespace" {
}

variable "cluster_name" {
  description = "cluster name"
}

variable "cluster_description" {
  description = "cluster description"
  default     = ""
}

variable "port" {
  description = "running port"
  default     = 6379
}

variable "security_group_name" {
  default     = ""
  description = "redis security group name"
}

variable "subnet_name" {
  default = ""
}

variable "family" {
  default = "redis6.x"
}

variable "node_type" {
  description = "node type"
}

variable "cluster_mode" {
  default = false
}

variable "automatic_failover_enabled" {
  description = ""
  default     = false
}

variable "number_replica" {
  description = ""
  default     = 2
}

variable "number_shard" {
  default     = 1
  description = ""
}

variable "subnet_ids" {
  description = "subnets"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "tags" {
  description = "tags"
  type        = map(string)
  default = {
  }
}


variable "apply_immediately" {
  default = false
}

variable "parameter_group_name" {
  default =  ""
}


variable "parameter" {
  default = []
}