module "vpc" {
  source               = "./vpc"
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  az_count             = var.az_count
  tag                  = var.tag
  cluster_name         = var.cluster_name
}

module "eks" {
  source               =  "./eks/control_plane"
  cluster_version      = var.cluster_version
  cluster_name         = var.cluster_name
  cluster_role_name    = var.cluster_role_name
  private_subnet_ids   = module.vpc.private_subnet_ids
  depends_on           = [ module.vpc ]
}

module "worker_node" {
  source                    =  "./eks/worker_node"
  node_group_name           =  var.node_group_name
  private_subnet_ids        =  module.vpc.private_subnet_ids
  desired_size              =  var.desired_size
  max_size                  =  var.max_size
  max_unavailable           =  var.max_unavailable
  min_size                  =  var.min_size
  cluster_name              =  var.cluster_name
  capacity_type             =  var.capacity_type
  instance_types            =  var.instance_types
  worker_node_iam_role_name =  var.worker_node_iam_role_name
  depends_on                = [ module.eks]
}

module "eks_addons" {
  source       = "./eks/eks_addons"
  for_each     = { for idx, addon in var.addons : idx => addon }    
  cluster_name = module.eks.cluster_name
  addon_name   = each.value.addon_name
  depends_on   = [ module.worker_node ]
}

module "karpenter" {
  source                    = "./karpenter"
  cluster_name              = var.cluster_name
  vpc_id                    = module.vpc.vpc_id
  karpenter_version         = var.karpenter_version
  cluster_security_group_id = module.eks.cluster_security_group_id
  depends_on                = [module.eks]  
}

module "argocd" {
  source        = "./argocd"
  chart_version = var.chart_version
  custom_values = var.custom_values
  depends_on    = [ module.worker_node ]  
}

