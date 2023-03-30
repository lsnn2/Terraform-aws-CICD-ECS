data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "main"

  cidr = var.vpc_cidr
  azs  = slice(data.aws_availability_zones.available.names, 0, 2)

  private_subnets = ["172.17.1.0/16", "172.17.2.0/16"]
  public_subnets  = ["172.17.3.0/16", "172.17.4.0/16"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
              Name   = "petclinic-public_subnets"
  }

  private_subnet_tags = {
              Name   = "petclinic-private_subnets"

  }
}