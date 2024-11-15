

resource "aws_subnet" "public_subnets" {
  count             = var.az_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 2 + count.index * 2)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name                    = "${var.tag}-public-${count.index + 1}"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = var.az_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 1 + count.index * 2)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name                                         = "karpenter-nodes-${var.cluster_name}"
    "kubernetes.io/role/internal-elb"            = "1"
    "karpenter.sh/discovery"                     = var.cluster_name
    "kubernetes.io/cluster/${var.cluster_name}"  = "owned"
  }
}
