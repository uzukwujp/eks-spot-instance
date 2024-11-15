
data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

data "aws_caller_identity" "current" {}

data "kubernetes_config_map" "aws_auth_existing" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
}

data "aws_region" "current" {}

data "tls_certificate" "default" {
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}