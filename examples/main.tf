module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "simple-vpc"
  cidr = "10.2.0.0/16"

  azs             = ["ca-central-1a", "ca-central-1b"]
  private_subnets = ["10.2.1.0/24", "10.2.2.0/24"]
  public_subnets  = ["10.2.101.0/24", "10.2.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false

  tags = {
    Name       = "simple-vpc"
    Enviroment = "Production"
  }

}

module "redis" {
  source                  = "Mehdikarimian/elasticache-redis-cluster/aws"
  version                 = "0.1.0"
  namespace               = "simple-redis-cluster"
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnets
  node_type               = "cache.t3.small"
  parameter_group_name    = "default.redis6.x"
  replicas_per_node_group = 1
  security_group_name     = "simple-redis-cluster-security-group"
  tags = {
    Name       = "simple-redis-cluster"
    Enviroment = "Production",
  }
}
