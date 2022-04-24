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
  namespace            = "redis-basic"
  cluster_name         = "redis-basic-example"
  source               = "Mehdikarimian/elasticache-redis-cluster/aws"
  version              = "1.0.3"
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.private_subnets
  node_type            = "cache.t3.small"
  cluster_description  = "redis basic example description"
  subnet_name          = "redis-basic-example-subnet"
  parameter_group_name = "RedisBasicExampleParameterGroup"
  apply_immediately    = true

  number_replica = 0

  security_group_name = "redis-basic-example-security-group"
  tags = {
    Name       = "redis-basic-example"
    Enviroment = "Production",
  }
}
