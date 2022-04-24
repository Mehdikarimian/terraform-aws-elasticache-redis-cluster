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
  namespace            = "test"
  source               = "Mehdikarimian/elasticache-redis-cluster/aws"
    version                 = "0.2.0"
  vpc_id               = module.vpc.vpc.id
  subnet_ids           = module.vpc.private_subnets.*.id
  node_type            = "cache.t3.small"
  cluster_description  = "test cluster"
  subnet_name          = "subnet"
  parameter_group_name = "TestParameterGroup"
  apply_immediately    = true

  cluster_mode               = true
  number_shard               = 2
  replicas_per_node_group = 1

  security_group_name = "redis-production-security-group"
  tags = {
    Name       = "simple-redis-cluster"
    Enviroment = "Production",
  }
}
