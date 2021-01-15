module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2"

  name = var.clusterName
  cidr = "10.0.0.0/16"

  azs = data.aws_availability_zones.available.names
  # "10.0.0.0/18", "10.0.64.0/18", "10.0.128.0/18" are the CIDR blocks dedicated to each AZ
  # Unallocated CIDR blocks are spares.
  # Each subnet is a divided piece of the AZs allocated CIDR block
  private_subnets  = ["10.0.0.0/21", "10.0.64.0/21", "10.0.128.0/21"]
  public_subnets   = ["10.0.8.0/21", "10.0.72.0/21", "10.0.136.0/21"]
  #database_subnets = ["10.0.16.0/21", "10.0.80.0/21", "10.0.144.0/21"]
  #elasticache_subnets = ["10.0.24.0/21", "10.0.88.0/21", "10.0.152.0/21"]
  # redshift_subnets    = ["10.0.32.0/21", "10.0.96.0/21", "10.0.160.0/21"]
  # intra_subnets       = ["10.0.40.0/21", "10.0.104.0/21", "10.0.168.0/21"]

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false
  enable_dns_hostnames   = false

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.clusterName}" = "shared"
    "kubernetes.io/role/elb"                   = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.clusterName}" = "shared"
    "kubernetes.io/role/internal-elb"          = "1"
  }

  tags = merge(local.commonTags, {
    env                                        = var.clusterName
    cost_center                                = "devops"
    "kubernetes.io/cluster/${var.clusterName}" = "shared"
  })
}
